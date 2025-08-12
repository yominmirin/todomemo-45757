class Priority < ActiveHash::Base
  self.data = [
    { id: 1, name: '低' },
    { id: 2, name: '中' },
    { id: 3, name: '高' }
  ]

  include ActiveHash::Associations
  has_many :tasks
end
