ActionController::Routing::Routes.draw do |map|
  map.resources :archives,
    :member => {:download => :get}
  map.resources :papers,
    :member => {:change => :get, :download => :get, :rebuild => :put}
  map.resources :parameters, :path_prefix => '/papers/:paper_id'
  map.connect ':controller/:action/:id'
  map.connect '', :controller => 'archives'
end
