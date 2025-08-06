require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    user = FactoryBot.create(:user)
    @task = FactoryBot.build(:task, user_id: user.id)
  end

  describe 'タスク新規投稿' do
    context 'タスクが投稿できる場合' do
      it 'すべての項目に要素がある場合投稿できる' do
        expect(@task).to be_valid
      end
      it 'titleが空欄の場合投稿できる' do
        @task.title = ''
        expect(@task).to be_valid
      end
      it 'detailsが空欄の場合投稿できる' do
        @task.details = ''
        expect(@task).to be_valid
      end
      it 'deadlineが空欄の場合投稿できる' do
        @task.deadline = nil
        expect(@task).to be_valid
      end
      it 'category_idが空欄の場合投稿できる' do
        @task.category_id = ''
        expect(@task).to be_valid
      end
      it 'priority_idが空欄の場合投稿できる' do
        @task.priority_id = ''
        expect(@task).to be_valid
      end
      it 'needs_editingがtrueの場合投稿できる' do
        @task.needs_editing = true
        expect(@task).to be_valid
      end
        it 'needs_editingがfalseの場合投稿できる' do
        @task.needs_editing = false
        expect(@task).to be_valid
      end
    end
    context 'タスクが投稿できない場合' do
      it 'userがnullの場合投稿できない' do
        @task.user_id = nil
        @task.valid?
        expect(@task.errors.full_messages).to include("User must exist")
      end
    end
  end
end
