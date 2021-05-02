class AuthController < ApplicationController

	skip_before_action :authorized

	def signupView
		if(logged_in?) 
			# redirect_to '/users/index'
      redirect_to users_index_path
		else
			@user ||= User.new
		end
  end

  def signup
		user_params = params.require(:user).permit(:name, :username, :password, :password_confirmation)
		@user = User.create(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      # redirect_to '/users/index'
      redirect_to users_index_path
    else  
      # redirect_to '/users/signup'
			render 'signupView'
    end
  end


  def loginView
		if(logged_in?) 
			# redirect_to '/users/index'
      redirect_to users_index_path
		else
			@user ||= User.new
		end
  end

	def login
		@user = User.find_by(username: params[:username])	
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      # redirect_to @user
      redirect_to users_index_path
    else  
      # redirect_to users_login_path
			render 'loginView'
    end
  end

	def logout
			session[:user_id] = nil
			@c_user = session[:user_id]
			@session = session[:user_id]
			redirect_to welcome_index_path
	end
end
