Artigo::Application.routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  
  map.resources :users
  map.resource :session
  map.resources :posts
  
  map.root :controller => "posts"
  
  map.post_permalink '/:year/:month/:day/:slug',
                    :controller => 'posts',
                    :action     => 'show',
                    :year       => /(19|20)\d{2}/,
                    :month      => /[01]?\d/,
                    :day        => /[0-3]?\d/
  
  map.connect '/admin', :controller => 'admin/dashboard', :action => 'index'
  map.connect '/sessions', :controller => 'sessions', :action => 'create', :method => 'post'
  map.connect '/page/:page', :controller => 'posts', :action => 'page'
  map.connect '/page/:page.:format', :controller => 'posts', :action => 'page', :format => 'html'
  map.connect '/rss', :controller => 'posts', :action => 'rss'  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
