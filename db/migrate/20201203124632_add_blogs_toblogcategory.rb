class AddBlogsToblogcategory < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :category_id, :integer
    add_column :blogs, :explanation, :string
  end
end
