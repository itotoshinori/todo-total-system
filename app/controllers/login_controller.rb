class LoginController < ApplicationController
  before_action :url_set, only: [:login]

  def index
    @num = rand(0..5)
    @imageauth = ImageAuth.new(@num)
    @image = @imageauth.auth_dis
  end

  def new
    @user=User.new()   
  end

  def create
  end

  def login
    mail=params[:mail]
    password=params[:password]
    image_word = params[:image_word]
    word = params[:word].to_i
    imageauth_word = ImageAuth.new(word).auth_dis_word
    @user = User.find_by(email:mail)
    @chatwork = InquiryChatwork.new
    #if @user and @user.authenticate(password) and image_word == imageauth_word
    if @user and @user.authenticate(password)
      cookies[:userid] = {:value => @user.id, :expires => 5.days.from_now } 
      cookies.signed[:secret] = {
      :value => password,
      :expires => 5.days.from_now
     }
      flash[:success]="ログインに成功しました"
      @chatwork.push_chatwork_message(@user, 2, @url)
      redirect_to '/'
    else
      @chatwork.push_chatwork_message(@user, 3, @url)
      flash[:warning]="ログインに失敗しました"
      redirect_to login_index_path
    end
  end 
  
  def logout
    cookies.delete :userid
    cookies.delete :passwd
    redirect_to login_index_path
  end
end
