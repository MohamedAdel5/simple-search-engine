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

end
