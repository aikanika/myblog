Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#一般的な処理を一気に設定
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :blogs
  resources :users, only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :categories

  root 'blogs#index'
#  root 'users#new'

  #管理画面
  get   'posts', to: 'posts#index'

  #カテゴリ管理
  get   'categories', to: 'categories#index'

  # ログイン / ログアウト
  get     'login',   to: 'sessions#new'
  post    'login',   to: 'sessions#create'
  delete  'logout',  to: 'sessions#destroy'

  # ユーザ登録
  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'

  # パスワードリセット
  get 'password_resets/new'
  get 'password_resets/edit'
end
