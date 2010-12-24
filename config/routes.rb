ActionController::Routing::Routes.draw do |map|
  map.root :controller => "walls"

  map.admin '/admin', :controller => "home", :action => "admin"
  map.save_info '/admin/info/save', :controller => "home", :action => "save_info"
  map.save_file '/admin/file/save', :controller => "home", :action => "save_file", :method => :post
  map.remove_file '/admin/file/:id/remove.:format', :controller => "home", :action => "remove_file"
  map.send_file '/admin/file/:id/send', :controller => "home", :action => "send_file"
  map.info '/info', :controller => "home", :action => "info"
  map.access_token '/access_token', :controller => "application", :action => "access_token"

  # WALL MESSAGE
  map.post_message '/message/post', :controller => "walls", :action => "post_message", :method => :post
  map.like_message '/message/like/:message_id', :controller => "walls", :action => "like_message", :method => :post
  map.unlike_message '/message/unlike/:message_id', :controller => "walls", :action => "unlike_message", :method => :post
  map.favorite_message '/message/favorite/:message_id', :controller => "walls", :action => "favorite_message", :method => :post
  map.unfavorite_message '/message/unfavorite/:message_id', :controller => "walls", :action => "unfavorite_message", :method => :post
  map.comment_message '/message/comment/:message_id', :controller => "walls", :action => "comment_message", :method => :post
  map.delete_message '/message/:message_id/delete', :controller => "walls", :action => "delete_message", :method => :delete

  map.resources :jobs, :member => { :apply => :post}
  map.resources :walls


  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
#  map.connect ':controller/:action/:id'
#  map.connect ':controller/:action/:id.:format'
end
