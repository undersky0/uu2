Uu2::Application.routes.draw do



  get "friendmap/index"

  resources :attachables

  resources :galleries

  resources :avatars
  
  resources :authentications

  
  resources :albums do
  resources :pictures do
    collection do
      post 'make_default'
    end
  end
  end
  
  resources :pictures

resources :messages do 
  get :autocomplete_profile_firstname, :on => :collection
end

#facebook  
#match '/users/auth/:provider/callback', to: 'authentications#create'




  resources :memberships, :only => [:create, :destroy]
  
  resources :groups do
    resources :albums do 
      resources :pictures
    end
    resource :scribbles
    member do
    post 'groupscribble', :action => :newgroupscribble
  end 
  end
  
  resources :localfeeds do
    resource :scribbles
    member do
      post 'localscribble', :action => :newlocalscribble
    end
  end

  resources :locations
  
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}
  
  resources :users do
    resource :avatar
    
  resource :profile 
  
  
  collection do
    post 'uploadfoto', :action => :uploadfoto
  end

  end  

  resources :scribbles do
        member do
      post 'localscribble', :action => :newlocalscribble
    end
    resources :comments

  end
resource :user
  get "navigation/home"
  
  
  
  root :to => 'localfeeds#index'
  get "navigation/feeds"
  get  "refresh"  => "navigation#refreshscribbles", :as => "refresh"
  get  "promote"  => "navigation#votedup", :as => "promote"
  get  "demote"  => "navigation#voteddown", :as => "demote"
  
  #get "browse/home"
  
  #get "views/profile"
  
   resources :friendships do
    collection do
      get 'request',:as=>"addfriend"
      get 'accept',:as=>"accept_fr"
      get 'reject',:as=>"reject_fr"
    end
  end
 
 get 'message/compose', to: 'messages#new', as: :compose

  
 resources :messages do
    collection do
      get 'index', to: 'messages#index', as: :index
      get 'sent', to: 'messages#sent', as: :sent
      post 'reply', to: 'messages#reply', as: :reply
      post 'trash', to: 'messages#trash', as: :trash
    end
  end

  post 'mailbox/empty_trash', to: 'mailboxes#empty_trash', as: :empty_trash
  get 'mailbox/:mailbox', to: 'mailboxes#show', as: :mailbox
  get 'mailbox/:mailbox/:id', to: 'messages#show', as: :mailbox_message
  
   match "/showusers/:id" => "users#showconnections", :as=>"showusers"
   
  #map.resources :scribbles, :has_many => :comments

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
