EcogwikiRuby::Application.routes.draw do

  devise_for :users, skip: [:sessions, :passwords, :registrations]
  devise_scope :user do
    get 'sp.sign_in', to: 'users/sessions#new', as: 'sign_in'
    post 'sp.sign_in', to: 'users/sessions#create', as: 'sign_in'
    delete 'sp.sign_out', to: 'users/sessions#destroy', as: 'sign_out'
  end

  match '/sp.changes', to: 'home#sp_changes'
  post '/sp.markdown', to: 'home#sp_markdown'
  match '/sp.searches', to: 'home#sp_searches'
  get '/sp.preferences', to: 'home#sp_preferences'
  post '/sp.preferences', to: 'home#save_sp_preferences'
  get '*wikipage', to: 'home#page_handler', wikipage: /.+/
  post '*wikipage', to: 'home#write_handler', wikipage: /.+/
  put '*wikipage', to: 'home#update_handler', wikipage: /.+/
  delete '*wikipage', to: 'home#remove_handler', wikipage: /.+/
  root :to => 'home#root_handler'

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
