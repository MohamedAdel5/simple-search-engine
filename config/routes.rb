Rails.application.routes.draw do

	root to: 'welcome#index'
  get 'welcome/index', to: 'welcome#index'

	get 'users/signup', to: 'auth#signupView'
	post 'users/signup', to: 'auth#signup'
	get 'users/login', to: 'auth#loginView'
	post 'users/login', to: 'auth#login'
	post 'users/logout', to: 'auth#logout'
	get 'users/index', to: 'users#index'
	get 'users', to: 'users#index'


  get '/searches', to: 'searches#searchView'
  post '/searches', to: 'searches#search'

	# error pages
	%w( 404 422 500 503 ).each do |code|
		get code, :to => "errors#show", :code => code
	end

	get '*path', to: "errors#show"

end
