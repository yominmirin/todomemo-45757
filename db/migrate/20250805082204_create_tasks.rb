class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
    t.string     :title
    t.text       :details
    t.date       :deadline
    t.integer    :status_id, default: 1
    t.integer    :category_id
    t.integer    :priority_id
    t.boolean    :needs_editing, default: false
    t.references :user, null: false, foreign_key: true
    t.timestamps
    end
  end
end
