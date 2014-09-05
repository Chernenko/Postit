PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy' # , as:'logout'
  get'/register', to: 'users#new'

  resources :posts, except: [:destroy] do
    member do
      post :vote
    end
    resources :comments, only: [:create] do
      member do
        post :vote
      end
    end
  end
  resources :categories, only: [:create,:new,:show]
  resources :users, only:[:show, :create, :edit, :update]
end
