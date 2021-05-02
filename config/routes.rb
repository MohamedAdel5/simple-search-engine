Rails.application.routes.draw do

  get 'welcome/index', to: 'welcome#index'
	get 'users/signup', to: 'auth#signupView'
	post 'users/signup', to: 'auth#signup'
	get 'users/login', to: 'auth#loginView'
	post 'users/login', to: 'auth#login'
	get 'users/logout', to: 'auth#logout'
	get 'users/index', to: 'users#index'


end
