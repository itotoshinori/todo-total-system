Rails.application.routes.draw do
  #分類別
  resources :categories, only: [:index]
  get 'categories/index_detail/' , to: 'categories#index_detail'
  get 'categories/detail_lists/' , to: 'categories#detail_lists'
  #会計集計
  resources :totalizations, only: [:index]
  get 'totalizations/account_item_index'
  get 'totalizations/index_month'
  #検索条件
  resources :search, only: [:index]
  get 'search/condition'
  post 'search/condition'
  #todo
  get 'todos/aggregate'
  get 'todos/finished'
  resources :todos
  post 'todos/createmany'
  post 'todos/termindex'
  #ｽｹｼﾞｭｰﾙ表
  resources :schedules, only: [:index]
  #会計関係
  resources :accounts, only: [:index,:create]
  put '/accounts/editmany'
  post 'accounts/itemindex'
  #ユーザー管理
  resources :users
  resources :login, only: [:new,:index]
  post 'users/password_reset'
  post 'login/login'
  get 'login/logout'
  #エラー時エラー画面に
  get 'error_display/index'
  #一斉削除
  resource :targets do
    collection do
      get :index
      delete :delete_many 
    end
  end
  #トップページを表示
  resources :portals
  #エクスポート
  get 'toexport/condition'
  post 'toexport/todocsvexport'
  post 'toexport/accountcsvexport'
  #ブログ
  delete 'blog/:id/delete', to: 'blogs#destroy'
  resources :blogs, except: [:delete]
  resources :comments, only: [:create]
  get '/'=>'portals#index'
  post '/comments/comment_error', as: :comment_error
  post 'todos/ajax_update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
