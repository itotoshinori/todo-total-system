class AddFinishdayToTodos < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :finishday, :date
  end
end
