class ToexportController < ApplicationController
  before_action :userid_set
  before_action :password_repair
  before_action :unless_user,  only: [:index,:indexfinished,:show,:edit,:schedule]
  require 'active_support/core_ext/date'

  def condition
    now = Time.current
    sdate = now.prev_month
    fdate = now.since(3.month)
    @startdate = Date.new(sdate.year, sdate.month, sdate.day) if @startdate.blank?
    @finishdate = Date.new(fdate.year, fdate.month, fdate.day) if @finishdate.blank?
    @idate = Todo.minimum(:term)
    timeselect
  end

  def todocsvexport
    @startdate = params[:startdate][:id]
    @finishdate = params[:finishdate][:id]
    @todos=Todo.includes(:accounts).where(user_id:@userid).where("term >= ?", @startdate).where("term <= ?", @finishdate)
    flash[:success]="エクスポートしました"
  end

  def accountcsvexport
    @startdate = params[:startdate][:id]
    @finishdate = params[:finishdate][:id]
    @accounts = Account.joins(:todo).where('todos.user_id = ?', @userid).where("registrationdate >= ?", @startdate).where("registrationdate <= ?", @finishdate)
    flash[:success] = "エクスポートしました"
  end
end
