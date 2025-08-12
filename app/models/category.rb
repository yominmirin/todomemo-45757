class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '仕事' },
    { id: 2, name: '学習' },
    { id: 3, name: '家事' },
    { id: 4, name: '買い物' },
    { id: 5, name: '健康' },
    { id: 6, name: '趣味' },
    { id: 7, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :tasks
end
