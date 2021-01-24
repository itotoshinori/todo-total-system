class SearchController < ApplicationController
  protect_from_forgery with: :exception
  before_action :userid_set
  before_action :password_repair
  before_action :unless_user
  before_action :timeselect
  require 'active_support/core_ext/date'
  def condition
    @title = params[:title]
    @startdate = params[:startdate]
    @finishdate = params[:finishdate]
    @now = Time.current
    now = Time.current
    sdate = now.prev_year
    fdate = now.since(3.month)
    @startdate = Date.new(sdate.year, sdate.month, sdate.day) if @startdate.blank?
    @finishdate = Date.new(fdate.year, fdate.month, fdate.day) if @finishdate.blank?
    @idate = Todo.minimum(:term)
    timeselect
  end

  def index
    @title = params[:title]
    @startdate = params[:startdate][:id]
    @finishdate = params[:finishdate][:id]
    @todos = Todo.includes(:accounts).where(user_id:@userid).where('title LIKE ?', "%#{@title}%").where("term >= ?", @startdate).where("term <= ?", @finishdate).order(:term).paginate(page: params[:page], per_page: 20)
    if params[:finished_only] == "1"
      @todos = @todos.where(finishday:nil)
      @finished_state = "未完了対象"
    else 
      @finished_state = "全対象"
    end 
    @kubun = 1
    if @todos.count >= 100
      flash.now[:warning] = "検索結果が100件を超えてます。絞り込みをお願いします"
      render search_condition_path
    elsif @todos.count == 0
      flash.now[:warning] = "該当データがありません。再設定をお願いします"
      render search_condition_path
    end
  end
end
