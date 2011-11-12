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
			
	match '/admin', 								:to => 'admin/dashboard#index'				
	match '/admin/config/changetheme', 				:to => 'admin/config#changetheme'
	match '/admin/themes/:theme/settings', 			:to => 'admin/theme_settings#edit'
	match '/admin/themes/:theme/settings/save', 	:to => 'admin/theme_settings#save'
	match '/tags/:id(.:format)', 					:to => 'tags#show', :defaults => { :format => 'html' }
	match '/sessions', 								:to => 'sessions#create', :via => 'post'
	match '/page/:page', 							:to => 'posts#page'
	match '/page/:page(.:format)', 					:to => 'posts#page', :defaults => { :format => 'html' }
				
	match 'logout',	 								:to => 'sessions#destroy'
	match 'login', 									:to => 'sessions#new'
	match 'page/:page(.:format)', 					:to => 'posts#page'
	match 'rss', 									:to => 'posts#rss'
	
	match '/:controller(/:action(/:id))'
	match '/:controller(/:action(/:id(.:format)))', :defaults => { :format => "html" }
	match "*rest" => "application#render_404"
end
