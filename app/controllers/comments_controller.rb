class CommentsController < ApplicationController
  require 'net/https'
  require 'json'
  before_action :url_set, only: [:create]

  def create
    @comment=Comment.new(comment_params)
    blog_id = @comment.blog_id
    if @comment.save
      cookies[:commnt_name] = {:value => @comment.name, :expires => 5.days.from_now }
      cookies[:commnt_email] = {:value => @comment.email, :expires => 5.days.from_now }
      cookies[:commnt_url] = {:value => @comment.url, :expires => 5.days.from_now }
      flash[:success]="コメントが新規登録されました"
      if cookies[:userid].blank?
        @chatwork = InquiryChatwork.new
        @chatwork.push_chatwork_message(@comment, 1, @url)
      end
      redirect_to "/blogs/#{blog_id.to_s}"
    else
      @blog=Blog.find(blog_id)
      @name=@comment.name
      @email=@comment.email
      @body=@comment.body
      render comment_error_path
    end
  end

  def comment_params
     params.require(:comment).permit(:name,:body,:blog_id,:email,:url)
  end
end
