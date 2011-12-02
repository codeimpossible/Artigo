Artigo::Application.routes.draw do
	resources :users, :posts 
	resource :session

	get "tags/index"
	get "tags/show"

	root :to => "posts#index"

	match '/:year/:month/:day/:slug',
			:to => 'posts#show',
			:constraints => {
				:year       => /(19|20)\d{2}/,
				:month      => /[01]?\d/,
				:day        => /[0-3]?\d/
			}, 
			:as => 'post_permalink'

	namespace :admin do
  		match '/' => 'dashboard#index'
  		resources 	:posts
  		resource 	:import
  		resource 	:config
  		resource 	:tidyup
  		resource 	:changepassword

  		get   '/config/edit', 						:to => 'config#edit'
  		post  '/config', 							:to => 'config#update'

		get   '/themes/:theme/settings', 			:to => 'theme_settings#edit', :as => 'theme_settings'
		post  '/themes/:theme/settings/save', 		:to => 'theme_settings#save', :as => 'theme_settings_save'
	end
	
	match '/tags/:id(.:format)', 					:to => 'tags#show', :defaults => { :format => 'html' }
	match '/sessions', 								:to => 'sessions#create', :via => 'post'
	match '/page/:page', 							:to => 'posts#page'
	match '/page/:page(.:format)', 					:to => 'posts#page', :defaults => { :format => 'html' }
				
	match 'logout',	 								:to => 'sessions#destroy'
	match 'login', 									:to => 'sessions#new'
	match 'rss', 									:to => 'posts#rss'

	match '/:controller(/:action(/:id(.:format)))', :defaults => { :format => "html" }
	match "*rest" => "application#render_404"
end