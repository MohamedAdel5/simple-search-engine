class UsersController < ApplicationController
  def index
		@searches = Search.where(:user_id => current_user.id)
  end
end
