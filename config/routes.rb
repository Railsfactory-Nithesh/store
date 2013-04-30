Store::Application.routes.draw do
  match '/payments/payment', :to => 'payments#payment', :as => 'paymentspayment', :via => [:get]

  match '/payments/thank_you', :to => 'payments#thank_you', :as => 'payments_thank_you', :via => [:get]

  resources :authentications

  post  "store/search"
  get "store/index"
  get 'admin' => 'admin#index'
  controller :sessions do
  get 'login' => :new
  post 'login' => :create
  end
 
    resources :users do
   collection do
   get :forgot_password   #the account-email submisison form url
   post :reset_password  #a url for the function that sends the response email
 end
 end
 
    #~ match '/auth/:provider/callback' => 'store#index'
    match '/logout'=>'sessions#destroy',:as=>'logout'
    match '/auth/:provider/callback' => 'authentications#create'

    root :to => 'store#index' , :as => 'store'
  
    resources :orders
    resources :line_items
    resources :carts
    resources :products do 
     get "category", :on => :collection
    end
    resources :password_resets

  
end
