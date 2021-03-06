Booksy::Application.routes.draw do
  get "messages/create"
  root 'pages#home'

  resources :conversations do
    resources :messages, only: [:create, :destroy]
  end

  resources :reviews
  resources :authors
  
  resources :archives do
    member do
      post :future_list
      post :past_list
    end
  end

  resources :links do
    member do
      put :start_future_link
      post :futurelink_list
      post :pastlink_list
    end
  end

  resources :collections
  resources :acomments
  
  resources :recommends do
    member do
      get :top_book
      get :top_author
    end
  end

  resources :books do
    member do
      put :start_future_read
      post :order
      post :add_goodreads
    end
  end

  resources :activities

  devise_for :users, :controllers => { :registrations => 'registrations'}
  resources :users, :only => [:show, :index]
  resources :users do
    member do
      get :readlist_past
      get :readlist_future
      get :recommendations
      get :follow
      get :unfollow
    end
  end

   get 'users/:id', to: 'users#show'
   get 'users/sign_out', to: 'devise/sessions#destroy'
   get 'users', to: 'users#index'
   get 'search/', to: 'pages#search'
   get 'future', to: 'books#future'
   get 'futurelink', to: 'links#future'
   get 'recommend', to: 'books#recommend'
   # reorder future list
   post 'books/reorder', to: 'books#reorder'
   get 'finished', to: 'archives#finishedmodal'
   get 'topbook', to: 'recommends#top_book'
   get 'topauthor', to: 'recommends#top_author'
   get 'brapi', to: 'books#goodread_search'
   get 'authapi', to: 'authors#goodread_search'
   get 'discover', to: 'pages#discover'
   get 'about', to: 'pages#about'


  get "pages/home"


  namespace :api, defaults: {format: :json} do
    scope "/book/:book_id", as: "book" do
      resources :discussions, only: [:index, :show, :create] do
        resources :commentaries, only: [:create, :update, :destroy]
      end
    end
  end

end
