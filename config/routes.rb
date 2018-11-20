Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#一般的な処理を一気に設定
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :blogs
  resources :users, only: [:create, :edit, :update]

  root 'blogs#index'
#  root 'users#new'

  #管理画面へ
  get   'posts', to: 'posts#index'

  # ログイン / ログアウト
  get     'login',   to: 'sessions#new'
  post    'login',   to: 'sessions#create'
  delete  'logout',  to: 'sessions#destroy'

  # ユーザ登録
  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'
end
