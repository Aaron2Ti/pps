ActionController::Routing::Routes.draw do |map|
  map.resources :archives
  map.resources :papers, :has_many => :parameters
  map.resources :assembles, :has_many => :parameters, :controller => :papers

  map.resources :parts, :has_many => :parameters, :shallow => true

  map.connect ':controller/:action/:id'
  map.root :controller => 'parts'
end
