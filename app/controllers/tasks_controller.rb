class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new

    @today_tasks_count = Task.where(user_id: current_user.id)
                           .where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
                           .count
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
  end

  def edit
    # Turbo Frameからのリクエストの場合
    if turbo_frame_request?
      # edit.html.erbをレンダリングする
      render :edit, layout: false
    else
      # それ以外（通常のページ遷移など）の場合は、editビューをレンダリングする
      render :edit
    end
  end

  def update
    if @task.update(task_params)
      if %w[cancel true false].include?(params[:task][:needs_editing])
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace('task-show-frame', partial: 'tasks/show_frame', locals: { task: @task }),
              turbo_stream.append('body', '<script>updateLayout();</script>')
            ]
          end
          format.html { redirect_to @task, notice: 'タスクが正常に更新されました。' }
        end
      else
        # もしneeds_editingが含まれない場合の処理（例：普通に更新完了してshowへリダイレクト）
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace('task-show-frame', partial: 'tasks/show_frame', locals: { task: @task }),
              turbo_stream.append('body', '<script>updateLayout();</script>')
            ]
          end
          format.html { redirect_to @task, notice: 'タスクが正常に更新されました。' }
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('edit_task', partial: 'tasks/edit_form', locals: { task: @task }),
                 status: :unprocessable_entity
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      if request.referer&.include?(tasks_path) # 一覧ページからの削除
        format.turbo_stream
        format.html { redirect_to tasks_path, notice: '削除しました' }
      else # 詳細ページなどからの削除
        format.html { redirect_to tasks_path, notice: '削除しました' }
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :category_id, :deadline, :priority_id, :details, :status_id,
                                 :needs_editing).merge(user_id: current_user.id)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
