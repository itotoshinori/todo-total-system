class Blog < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  has_many :comments, dependent: :destroy

  enum category_id: { 
  世界文学: 1,
  世界遺産: 2,
  世界映画: 3,
  プログラム:4,
  ドラマ:5 }
end
