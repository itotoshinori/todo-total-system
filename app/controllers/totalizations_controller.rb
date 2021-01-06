class TotalizationsController < ApplicationController
  before_action :userid_set
  before_action :password_repair
  before_action :data_set
  before_action :date_setteing

  def index
    @todos = Todo.where(user_id:@userid)
    @accounts = Account.joins(:todo).where('todos.user_id = ?', @userid)
    @today = Date.today
  end

  def index_month
    @accounts = Account.joins(:todo).where('user_id = ?', @userid).order(registrationdate:"DESC")
    @acym = []
    @accounts.each do |f|
     if f.registrationdate.present? 
      ym=Date.new(f.registrationdate.year,f.registrationdate.month , 1) 
      if @acym.count(ym)==0
        @acym << ym
      end
     end
    end
  end

  def account_item_index
   if params[:year] == "true"
    @first_day = @date.beginning_of_year
    @last_day = @date.end_of_year
    @year = "true"
   end  
    @today = Date.today
    @accounts = Account.joins(:todo).where("registrationdate >= ? and registrationdate <= ?", @first_day, @last_day).where("todos.user_id = ?", @userid)
    @item_max = Item.ids.max #push時こちらに変更すること
  end
  private
    def date_setteing
        @kubun=params[:kubun]
      if @kubun.present?
        @date=params[:lday].to_date
      else
        @date = Date.today
      end
      @first_day = @date.beginning_of_month
      @last_day = @date.end_of_month
    end
end
