class AccountsController < ApplicationController
  protect_from_forgery :except => [:itemindex,:itemaggregateyear]
  require 'date'
  before_action :userid_set,   only: [:index,:itemaggregate,:itemindex,:accountcsvexport,:itemaggregateyear,:monthlychangesaccount]
  include ApplicationHelper
  
  def index
    date=params[:registrationdate]
    @accounts = Account.joins(:todo).where('todos.user_id = ?', @userid).where('registrationdate = ?',date)
  end
 
  def new
  
  end
  
  def create
    today=Date.today
    @account = Account.new(
      item:params[:item],
      amount:params[:amount],
      remark:params[:remark],
      todo_id:params[:id],
      registrationdate:today)
    if  @account.save
      flash[:success]="会計が新規登録されました"
    else 
      session[:item]=params[:item]
      session[:remark]=params[:remark]
      flash[:danger]="会計登録に失敗しました。必須項目に入力がありません。"
    end
    redirect_to "/todos/#{@account.todo_id}"
  end

  def editmany
    accountsmanyedit_params.each{|id,val|amount,remark,item,deletecheck = val.values_at("amount","remark","item","deletecheck")
    @account = Account.find(id)
    if deletecheck == "1"
      @account.destroy
    else
      @account.update(
        amount:amount,
        remark:remark,
        item:item)
    end
    }
    flash[:success] = "会計データを更新しました"
    redirect_to "/todos/#{@account.todo_id}"
  end

  def itemaggregate
    kubun=params[:kubun]
    if kubun.present?
      @date=params[:lday].to_date
    else
      @date = Date.today
    end
    @accounts=Account.joins(:todo).where('todos.user_id = ?', @userid)
  end

  def itemaggregateyear
    itemaggregate
  end

  def itemindex
    item=params[:item]
    first=params[:firstday]
    last=params[:lastday]
    @accounts=Account.joins(:todo).where('todos.user_id = ?', @userid).where("registrationdate >= ?", first).where("registrationdate <= ?", last).where(item:item)
  end

  def accountcsvexport
    @startdate= params[:startdate][:id]
    @finishdate=params[:finishdate][:id]
    @accounts=Account.joins(:todo).where('todos.user_id = ?', @userid).where("registrationdate >= ?", @startdate).where("registrationdate <= ?", @finishdate)
    flash[:success]="エクスポートしました"
  end

  def monthlychangesaccount
    @accounts=Account.joins(:todo).where('user_id = ?', @userid).order(registrationdate:"DESC")
    @acym=[]
    @accounts.each do |f|
     if f.registrationdate.present? 
      ym=Date.new(f.registrationdate.year,f.registrationdate.month , 1) 
      if @acym.count(ym)==0
        @acym << ym
      end
     end
    end
  end

private
  def accountsmanyedit_params
    params.permit(accountsmany: [:amount,:remark,:item,:deletecheck])[:accountsmany]
  end
end
