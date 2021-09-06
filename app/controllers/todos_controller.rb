class TodosController < ApplicationController
  #protect_from_forgery with: :exception
  before_action :userid_set
  before_action :password_repair
  before_action :unless_user,  only: [:index,:indexfinished,:show,:edit,:schedule]
  before_action :timeselect,   only: [:new,:create,:edit,:update,:index,:searchresult,:research]
  before_action :place_setting, only: [:index]
  before_action :data_set
  require 'active_support/core_ext/date'

  def index
    if params[:finished] == "true"
      @todos = Todo.where(finished:true).where(user_id:@userid).order(finishday: "DESC").paginate(page: params[:page], per_page: 25).order(created_at: "DESC")
      @kubun = 2
    elsif params[:unfinished] == "true"
      @todos = Todo.includes(:accounts).where(finished:false).where(user_id:@userid).order(:term).paginate(page: params[:page], per_page: 25).order(created_at: "ASC")
      @unfinished = true
      @kubun = 1
    elsif params[:termdate].present?
      date = params[:termdate]
      @todos = Todo.includes(:accounts).where(user_id:@userid).where(term:date).order(finishday: "DESC").order(created_at: "DESC").paginate(page: params[:page], per_page: 25).order(created_at: "ASC")
      @kubun = 1
    elsif params[:finishday].present?
      date = params[:finishday]
      @todos = Todo.includes(:accounts).where(user_id:@userid).where(finishday:date).order(created_at: "DESC").paginate(page: params[:page], per_page: 25).order(created_at: "ASC")
      @kubun = 2
    else
      @todos = Todo.where(finished:false).or(Todo.where(finishday:@date))
      @todos = @todos.includes(:accounts).where(user_id:@userid).order(:term).paginate(page: params[:page], per_page: 25).order(created_at: "ASC")
      @kubun = 1
    end
    if cookies[:time_check12].blank? and @userid.to_s == "1"
    #if @userid.to_s == "1"
      #begin
        #url = "https://www.udemy.com/ja"
        #url = "http://titonet384.sakura.ne.jp/kokuho/"
        #title = "Udemyバーゲン購入検討"
        #title = "関西歴史建造物" テスト用
        #todo_count = Todo.where('title like ?',"%#{title}%").where(term:@date).count
        #if todo_count == 0
          #@scrap = Scrap_check.new
          #@udemy_check = @scrap.check(@userid,url,title,"セール","対象コースが","バーゲン")
          #flash[:success] = "#{title}が新規登録されました" if @udemy_check
        #else
          #flash[:success] = "Udemyの対象がありません"
        #end
      #rescue => exception
        #udemy_check = false
      #end
      begin
        @tv_schedule2 = Tv_guide.new.schedule_add(@userid)
        #クッキー更新
        cookies[:time_check12] = { :value => "check", :expires => 360.minutes.from_now } 
      rescue => exception
        @tv_schedule2 = ["ERROR","TV番組取得時エラーがでました"]
      end
    else
      #テレビ番組予約取消したもので昨日以前のものを削除　番組取込しない時に実行（同時するとエラーが起こる）
      todo_destroys = Todo.where("term <= ? and title LIKE ?", @date,"🚯%")
      if todo_destroys.present?
        todo_destroys.each do | todo_destroy |
          if todo_destroys.find(todo_destroy.id).delete
            flash[:success] = "🚯印のものを一括削除に成功しました"
          else
            flash[:warninng] = "🚯印のものを全部もしくは一部の一括削除に成功しました" 
          end
        end
      end  
    end
    #@tv_schedule = Tv_schedule.new.schedule_add(@userid)
    #@tv_schedule2 = Tv_guide.new.schedule_add(@userid)
  end

  def termindex
    date=params[:termdate]
    @todos=Todo.where(user_id:@userid).where(term:date).order(finishday: "DESC").order(created_at: "DESC")
  end
  
  def new
    now = Time.current  
    sdate = now
    sdate = params[:gday].to_date if params[:section] == "1"
    @sdate  = Date.new(sdate.year, sdate.month, sdate.day)
    @todo = Todo.new
  end
  
  def create
    @todo = Todo.new(todo_params)
    @todo.user_id=@userid
    @starttimehour=@todo.starttimehour
    @starttimemin=@todo.starttimemin
    newcreate
    if  @todo.save
      flash[:success]="#{@todo.title}が新規登録されました"
      if @todo.itemmoney.present?
        today = Date.today
        acoount = Account.new
        result = acoount.accountcreate(today,@todo)
        flash[:success] = "#{@todo.title}が会計含め登録されました" if result
      end
      @category = Category.new
      @categories = @category.category_array(@todo)
      @category.category_insert(@categories,@todo.id) if @categories.present?
      redirect_to "/todos/#{@todo.id}"
    else
      flash[:danger]="必須項目に入力がありません"
      @sdate=@todo.term
      @body=@todo.body
      render 'new'
    end
  end

  def createmany
    openday=params[:openday].to_date
    finishday=params[:finishday].to_date
    interval=params[:interval]
    title=params[:title]
    body=params[:body]
    count=0
    if title.present?
      while openday <= finishday
        @todo = Todo.new(
        term:openday,
        title:title,
        body:body,
        user_id:@userid)
        openday=openday.next_day(interval.to_i)
        @todo.save
        count+=1
      end
    end
    if count > 0
      flash[:success] = "「#{title}」が#{count}件追加されました"
    else
      flash[:warning] = "登録に失敗しました。日付や必須項目等確認し再登録下さい。"
    end
    redirect_to request.referer
  end

  def edit
    begin
      @url = request.referer
      @todo = Todo.find(params[:id])
    rescue => exception
      redirect_to error_display_index_path
    end
  end

  def update
    if params[:commit]=="修正登録"
      @todo = Todo.find(params[:id])
      starttimehour=todo_params[:starttimehour]
      starttimemin=todo_params[:starttimemin]
      if starttimehour.blank? or starttimemin.blank?
        @todo.starttime=nil
      else
        @todo.starttime="2000-01-01 #{starttimehour}:#{starttimemin}".to_datetime
        @todo.starttime=@todo.starttime-32400
      end
      if @todo.update(todo_params)
        @category = Category.new
        category_ids = Category.where(todo_id:@todo.id)
        @category.category_update(category_ids, todo_params[:category_id], todo_params[:category_id2], todo_params[:category_id3],@todo.id)
        flash[:success]="「#{@todo.title}」が編集されました"
        redirect_to "/todos/#{@todo.id}"
      else
        flash[:danger]="編集に失敗しました"
        render 'edit'
      end
    elsif params[:commit]=="コピー登録"
      @todo = Todo.new(todo_params)
      @todo.user_id=@userid
      @starttimehour=@todo.starttimehour
      @starttimemin=@todo.starttimemin
      newcreate
      if @todo.save
        flash[:success]="「#{@todo.title}」がコピー新規登録されました"
        @category = Category.new
        @categories = @category.category_array(@todo)
        @category.category_insert(@categories,@todo.id) if @categories.present?
        #category_create
        redirect_to "/todos/#{@todo.id}"
      else
        flash[:danger]="新規登録に失敗しました"
        render 'new'
      end
    elsif params[:commit]=="削除"
      @todo=Todo.find(params[:id])
      if @todo.destroy
        flash[:success]="「#{@todo.title}」が削除されました"
      else
        flash[:danger]="「#{@todo.title}」の削除に失敗しました"
      end
      redirect_to session[:url]
    end
  end

  def finished
    todo=Todo.find(params[:id])
    if params[:baction]=="1"
      todo.finished=true
      todo.finishday=Date.today
      todo.save
      flash[:success]="#{todo.title}が完了登録されました"
    else
      todo.finished=false
      todo.finishday=nil
      todo.save
      flash[:success]="#{todo.title}が完了登録取消されました"
    end
    redirect_to request.referer
  end

  def ajax_update
    # topページにある「data(入力フォーム)」のパラメーターを@textに代入
    id =params[:id] 
    todo = Todo.find(id)
    todo.finished = true
    todo.finishday = Date.today
    todo.title = "🚯#{todo.title}"
    todo.starttime = nil
    todo.finishtime = nil
    if todo.save
      @message = "テレビ番組視聴を中止にしました"
    else
      @message = "テレビ番組視聴を中止処理に失敗しました"
    end
  end
  
  def show
    begin
      @todo = Todo.includes(:accounts).find(params[:id])
      @categories = Category.where(todo_id:params[:id])
    rescue => exception
      redirect_to error_display_index_path
    end
  end

  private
    def todo_params
      params.require(:todo).permit(:title, :body,:term,:starttimehour,:starttimemin,:item,:itemmoney,:remark,:category_id,:category_id2,:category_id3)
    end

    def newcreate
      if @starttimehour.present? and @starttimemin.present?
        @todo.starttime="2000-01-01 #{@starttimehour}:#{@starttimemin}".to_datetime if @starttimehour.present? and @starttimemin.present?
        @todo.starttime=@todo.starttime-32400
      end
    end
end
