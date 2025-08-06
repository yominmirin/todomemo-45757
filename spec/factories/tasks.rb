FactoryBot.define do
  factory :task do
    title         { "taskname" }
    details       { "taskinfo" }
    deadline      { Date.today + 7.days }
    status_id     {1}
    category_id   {1}
    priority_id   {1}
    needs_editing { false }
  end
end
