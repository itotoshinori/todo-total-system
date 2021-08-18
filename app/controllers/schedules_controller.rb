class SchedulesController < ApplicationController
  protect_from_forgery with: :exception
  before_action :userid_set
  before_action :password_repair
  before_action :unless_user,  only: [:index,:indexfinished,:show,:edit,:schedule]
  before_action :place_setting, only: [:index]

  def index
    if params[:important] == "true"
      @events = Todo.where('title LIKE ?', '%🚩%').where(user_id:@userid)
      @important = true
    else
      @events = Todo.where('starttime IS NOT NULL').where(user_id:@userid)
    end
    kubun = params[:kubun]
    if kubun.present?
      @date = params[:lday].to_date
    else
      @date = Date.today
      @datekakuni = "true"
    end
  end
end
