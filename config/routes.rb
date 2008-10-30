ActionController::Routing::Routes.draw do |map|
  map.resources :archives, :shallow => true,
    :member => {:download => :get} do |archive|
    archive.resources :papers,
      :member   => {:change => :get, :download => :get, :rebuild => :put},
      :has_many => :parameters
    archive.resources :parts, :controller => 'papers'
    archive.resources :assembles, :controller => 'papers'
  end


  map.connect ':controller/:action/:id'
  map.connect '', :controller => 'archives'
end
