class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: 'タスクを登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      if request.referer&.include?(task_path(@task))
        # 詳細ページから削除された場合 → 一覧ページへリダイレクト
        format.turbo_stream { redirect_to tasks_path, notice: "タスクを削除しました" }
        format.html { redirect_to tasks_path, notice: "タスクを削除しました" }
      else
        # 一覧ページから削除された場合 → 部分更新
        format.turbo_stream
        format.html { redirect_to tasks_path, notice: "タスクを削除しました" }
      end
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :category_id, :deadline, :priority_id, :details, :needs_editing).merge(user_id: current_user.id)
  end
end
