class Category < ApplicationRecord
  belongs_to :todo
  validates :todo_id, presence: true
  validates :category_id, presence: true
    
  enum category_id: { 
  医療: 1,
  薬: 2,
  検査結果: 3,
  プログラム:4,
  映画・TV・本:5,自宅:6,
  税金等支払:7,
  スポーツ:8, 
  旅行:9,
  保険等:10,
  契約書:11,
  ブックマーク:12,
  転職活動:13,
  健康管理:14}

  def category_array(todo)
    if todo.category_id.present? or todo.category_id2.present? or todo.category_id3.present?
      categories = []
      categories << todo.category_id if todo.category_id.present?
      categories << todo.category_id2 if todo.category_id2.present?
      categories << todo.category_id3 if todo.category_id3.present?
    end
    categories
  end
  
  def category_insert(categories,todo_id)
    result = false
    categories.each do |category|
      @category = Category.new(todo_id:todo_id,category_id:category.to_i)
      result = true if @category.save
    end
    result
  end

   def  category_update(category_ids,category1,category2,category3,todo_id)
    category_edit_ids = [category1,category2,category3] 
    count = 0
    category_ids.each do | category |
      category_edit_id = category_edit_ids[count].to_i
      if category_edit_id == 0
        category.destroy
      else
        category.category_id = category_edit_id
        category.save
      end
      count = count + 1 
    end
    if count < 3
      for count in count..2 do
        if category_edit_ids[count] != ""
          category = Category.new(category_id: category_edit_ids[count].to_i,todo_id:todo_id)
          category.save
        end
      end
    end 
  end
end
  