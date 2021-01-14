class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  include ApplicationHelper
  helper_method :current_user
  require 'date'
  before_action :current_user_set, only: [:password_repair,:unless_user,:unless_admin_user]

  def userid_set
    if cookies[:userid].present?
      @userid=cookies[:userid].to_i
      cookies[:userid] = {:value => @userid, :expires => 5.days.from_now }
      password = cookies.signed[:secret]
      cookies.signed[:secret] = {
      :value => password,
      :expires => 5.days.from_now
     }
      @current_user = User.find(cookies[:userid].to_i)
    else
      redirect_to login_index_path
    end
  end

  def password_repair
    if @current_user.present?
      if @current_user.authenticate("password") 
        flash[:danger] = "パスワードを変更して下さい"
        redirect_to edit_user_path @current_user.id
      end
    end
  end

  def unless_user
    unless @current_user.authenticate(cookies.signed[:secret])
      cookies.delete :userid
      redirect_to login_index_path
    end
  end

  def unless_admin_user
    if @current_user.present?
      redirect_to('/login/index') if @current_user.id != 1
    end
  end

  def unless_login
    redirect_to('/login/index') if cookies[:userid].blank?
  end
  
  def data_set
    @date = Date.today
  end

  def timeselect
      @hourselect=[*0..23]
      @minselect=[*0..59]
      @interval=[*1..90]
      now = Time.current
      @dates=Array.new()
      @idate=now.last_year if @idate.blank?
      @ldate=now.next_year
      (@idate.to_datetime..@ldate).each do|c|
        date = Date.new(c.year, c.month, c.day)
        wd = ["日","月", "火", "水", "木", "金", "土"]
        iw=c.strftime("%Y/%m/%d(#{wd[c.wday]})")
        @dates << Datecollection.new(date,iw)
      end
    end

    def place_setting
      userid_set
      user = User.find(@userid)
      placecode = user.placecode
      @placename = Place.find_by(code:placecode).name
      @weather = Weather.new(placecode)
    end

    def url_set
      protocol = request.protocol
      host = request.host
      @url = "#{ protocol }#{ host }/" #現在のurlを取得
    end
  
    private
    def current_user_set
      if cookies[:userid].present?
        @current_user = User.find(cookies[:userid].to_i)
      end
    end
end
