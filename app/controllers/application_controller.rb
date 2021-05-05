class ApplicationController < ActionController::Base

	before_action :authorized

	helper_method :current_user
	helper_method :logged_in?

	def current_user   
		# if session[:user_id]
    #   @c_user = User.find(session[:user_id]) # current user
    # end

		# instead of getting the user everytime from the db, you get it from the session store (redis)
		return session[:user]
	end

	def logged_in?     
    !current_user.nil?
	end

	def authorized
		redirect_to welcome_index_path unless logged_in?
	end

end
