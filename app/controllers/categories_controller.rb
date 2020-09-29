class CategoriesController < ApplicationController
   before_action :userid_set

  def index
    categories = Category.joins(:todo).where('user_id = ?',@userid).order(:category_id)
    @category_ids = []
    category_id2 = nil
    start = true  
    count = 0
    unfinish_count = 0
    total_count = 0
    categories_count = categories.count
    
    categories.each do |category|
      if  category.category_id != category_id2
        @category_ids.push([category_id2, count,unfinish_count]) if start == false
        category_id2 = nil
        count = 0
        unfinish_count = 0
        start = false
      end
      category_id2 = category.category_id
      count = count + 1
      unfinish_count = unfinish_count + 1 if category.todo.finishday.present?
      total_count = total_count + 1
      if total_count == categories_count
       @category_ids.push([category.category_id, count,unfinish_count])
      end
    end
  end

  def index_detail
      @category =  params[:category]
      @index_details = Category.joins(:todo).where(category_id: @category).order(term:"DESC")
      #@index_details = Category.where(category_id:@category).order(id: "DESC")
  end
end
