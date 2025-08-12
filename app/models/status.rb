class Status < ActiveHash::Base
  self.data = [
    { id: 1, name: '作業前' },
    { id: 2, name: '作業中' },
    { id: 3, name: '完了' }
  ]

  include ActiveHash::Associations
  has_many :tasks
end
