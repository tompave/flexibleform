FlexibleForm::Application.routes.draw do

  root :to => 'home#home'

  match '/save', to: 'home#create_submission', via: :post
  match '/end', to: 'home#end'


  match '/dashboard', to: 'admin#dashboard'

  match '/delete/:visit_id', to: 'admin#destroy_visit', via: :delete

  match '/dashboard/edit_texts/:page', to: 'admin#text_edit', as: 'text_edit'
  match '/dashboard/update_texts', to: 'admin#update_texts', via: :put, as: 'update_text'

  match '/dashboard/edit_email_template', to: 'admin#email_edit', as: 'email_edit'
  match '/dashboard/update_email_template', to: 'admin#update_email', via: :put, as: 'update_email'

  match '/dashboard/export', to: 'admin#export', as: :download_export
  
  # feedback_path(:token) - feedback_url(:token)
  match '/fb/:token', to: 'feedbacks#land', as: :feedback


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
