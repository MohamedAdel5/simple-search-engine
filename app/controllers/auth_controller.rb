class AuthController < ApplicationController

	skip_before_action :authorized

	def signupView
		if(logged_in?) 
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
      # session[:user_id] = @user.id
			session[:user] = @user
      redirect_to users_index_path
    else  
			render 'signupView'
    end
  end


  def loginView
		if(logged_in?) 
      redirect_to users_index_path
		else
			@user ||= User.new
		end
  end

	def login
		user_params = params.require(:user).permit(:username, :password)
		@user = User.find_by(username: user_params[:username])
    if @user && @user.authenticate(user_params[:password])
      # session[:user_id] = @user.id
			session[:user] = @user
      redirect_to users_index_path
    else  
			render 'loginView'
    end
  end

	def logout
			# session[:user_id] = nil
			@session = nil
			session[:user] = nil
			redirect_to welcome_index_path
	end

end
