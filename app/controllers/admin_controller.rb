class AdminController < ApplicationController
	  before_filter :check_user
  before_filter :check_admin
def index
	   if session[:user_id].present?
    @user = User.find_by_id(session[:user_id])
    @user_name = @user.username
		end
end
end