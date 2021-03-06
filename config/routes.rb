ActionController::Routing::Routes.draw do |map|
  map.signup '/signup', :controller => 'users',         :action => 'new'
  map.login  '/login',  :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'

  map.resource :user_session
  map.resource :account, :controller => 'users'
  map.resources :users
  
  map.resources :suppliers
  map.resources :tags, :only => [:index]

  map.with_options(:namespace   => 'account/',
                   :name_prefix => 'account_',
                   :path_prefix => 'account') do |account|
    account.resources :tags, :parts
  end

  map.resources :parts,
                :member => {:add_tags => :put, :change => :get, :transform => :put},
              # :collection => {:tag => :get},
                :has_many => [:parameters],
                :shallow => true
  map.papers_tagged '/parts/tagged/:tag_ids',
    :controller => 'parts',
    :action     => 'tagged',
    :method     => :get

  map.resources :archives
  map.resources :papers, :has_many => :parameters
  map.resources :assembles, :has_many => :parameters, :controller => :papers

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action'
  map.root :controller => 'parts'
end
