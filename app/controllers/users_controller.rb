class UsersController < ApplicationController
  before_action :userid_set,  only: [:index,:new,:edit,:update]
  before_action :unless_admin_user,  only: [:index,:destroy]

  def index
    @users = User.all
  end

  def new
  end
  
  def create
    password = params[:password]
    password_confirmation = params[:password_confirmation]
    if password != password_confirmation
     flash[:success] = "パスワードが一致しません再入力して下さい"
     redirect_to '/user/new'
    end
    name = params[:name]
    email = params[:email]
    code = params[:placecode]
    user = User.new(
      name:name, email:email, placecode:code,
      password:password, admin:false) 
    if user.save
      cookies[:userid] = {:value => user.id, :expires => 5.days.from_now }
      flash[:success] = "ユーザー登録されました"
    else
      flash[:success] = "ユーザーに失敗しました。再度登録して下さい"
    end
    redirect_to '/'
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "削除に成功しました"
    redirect_to '/'
  end

  def edit
    @user = User.find(@userid)
  end

  def update
    id = cookies[:userid].to_i
    @user = User.find(id)
    email = params[:email]
    pass = params[:password]
    newpass = params[:newpassword]
    passcon = params[:password_confirmation]
    placecode = params[:placecode]
    #email=User.find(cookies[:userid].to_i).email
    name = params[:name]
    if  @user.authenticate(pass).present? and newpass == passcon
      if newpass.present?
        newpass = params[:newpassword] 
      elsif  newpass.blank?
        newpass = pass
      end
      @user.password = newpass 
      @user.name = name
      @user.email = email
      @user.placecode = placecode
      if @user.save
        flash[:success] = "修正に成功しました"
      else
        flash[:warning] = "修正に失敗しました。再度処理方願います。"
      end
      redirect_to '/'
    else   
      flash[:warning] = "パスワード等入力に誤りがありました。修正に失敗しました。"
      redirect_to "/users/#{@user.id}/edit"
    end
  end

  def password_reset
    password_reset = User.new.password_reset(params[:id])
    if password_reset
      flash[:success] = "該当のユーザーパスワードを「helppass」に変更しました。"
    else
      flash[:warning] = "該当のユーザーパスワード変更に失敗しました。"
    end
    redirect_to '/'
  end
end
