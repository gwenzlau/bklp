Booksy::Application.routes.draw do
  get "messages/create"
  root 'pages#home'

  resources :conversations do
    resources :messages, only: :create
  end

  resources :reviews

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
      post :future_list
      post :past_list
      get :author
      post :order
    end
  end

  resources :activities

  devise_for :users
  resources :users, :only => [:show, :index]
  resources :users do
    member do
      get :pastreads
      get :futurereads
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
   get 'author', to: 'books#author'
   get 'recommend', to: 'books#recommend'
   # api route for autocomplete
   get 'search/autocomplete', to: 'pages#autocomplete'
   # reorder future list
   post 'books/reorder', to: 'books#reorder'
   get 'finished', to: 'books#finishedmodal'
   get 'topbook', to: 'recommends#top_book'
   get 'topauthor', to: 'recommends#top_author'


  get "pages/home"


  namespace :api, defaults: {format: :json} do
    scope "/book/:book_id", as: "book" do
      resources :discussions, only: [:index, :show, :create] do
        resources :commentaries, only: [:create, :update, :destroy]
      end
    end
  end



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
