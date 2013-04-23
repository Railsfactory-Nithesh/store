Store::Application.routes.draw do
  resources :authentications


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
    resources :products
    resources :password_resets

  
end
