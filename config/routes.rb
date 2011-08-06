Iconsign::Application.routes.draw do
  
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  
  get "forgot_password" => "sessions#forgot_password", :as => "forgot_password"
  match "users/reset_password" => "users#forgot_password"
  
  get "manage_images" => "images#index", :as => "manage_images"
  get "checkout" => "orders#new", :as => "checkout"
  
  get 'my_orders' => 'users#my_orders', :as => 'my_orders'
  get "my_items" => "users#my_items", :as => "my_items"
  
  get 'display_order_detail' => 'items#display_order_detail', :as => 'display_order_detail'
  
  get "about" => "items#about", :as => "about"

  
  resources :items do
    resources :images
    resources :comments do
      get 'notify_admin', :on => :member
    end
  end
  
  resources :comments do
    get 'notify_admin', :on => :member
  end
  resources :users, :items, :images, :carts, :sessions, :orders, :tags
  
  match "/search/index" => "search#index"   
  match "/carts/add/:id" => "carts#add#id"
  match "/carts/remove/:id" => "carts#remove#id"

  get 'admin_main' => 'users#admin_main', :as => 'admin_main'  
  get 'manage_items' => 'items#manage_items', :as => 'manage_items'
  get 'manage_orders' => 'orders#index', :as => 'manage_orders'
  get 'manage_users' => 'users#index', :as => 'manage_users'
  
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
  root :to => "items#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
