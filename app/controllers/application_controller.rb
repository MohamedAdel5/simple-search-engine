class ApplicationController < ActionController::Base

	before_action :authorized

	helper_method :current_user
	helper_method :logged_in?

	def current_user   
		if session[:user_id]
      @c_user = User.find(session[:user_id]) # current user
    end
	end

	def logged_in?     
    !current_user.nil?
	end

	def authorized
		redirect_to welcome_index_path unless logged_in?
	end

end
