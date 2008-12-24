ActionController::Routing::Routes.draw do |map|
  map.resources :parts, :member => {:change => :put}, 
    :has_many => :parameters, :shallow => true

  map.resources :archives
  map.resources :papers, :has_many => :parameters
  map.resources :assembles, :has_many => :parameters, :controller => :papers

  map.connect ':controller/:action/:id'
  map.root :controller => 'parts'
end
