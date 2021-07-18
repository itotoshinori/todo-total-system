class TargetsController < ApplicationController
  before_action :userid_set
  before_action :password_repair
  before_action :data_set
  before_action :setting  
  protect_from_forgery with: :exception

  def index
    @date = params[:date] if params[:date].present?
    @targets = []
    @targets = @todo.todo_delete_target(@date.to_date,@userid)
  end

  def delete_many
    @date = params[:date] if params[:date].present?
    @targets = @todo.todo_delete_target(@date.to_date,@userid)
    @targets.each do | id,title,term |
      if Todo.find(id).delete
        flash[:success] = "一括削除に成功しました"
      else
       flash[:warninng] = "全部もしくは一部の一括削除に成功しました" 
      end
    end
    redirect_to targets_path
  end

  private
  def setting
    @todo = Todo.new
    @date = ( @date.to_date - 180 ).end_of_month
    @targets = [] 
  end
end