class SessionsController < ApplicationController
  
  skip_before_filter :check_user
  def new
  end



  def create
if user = User.authenticate(params[:username], params[:password])
session[:user_id] = user.id
session[:is_admin] = user.is_admin
 if params[:remember_me]
      cookies.permanent[:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token
      end
        if user.is_admin
        redirect_to admin_url
        flash[:notice]="Hi #{user.username} you are logged on"
        else
        redirect_to store_url
	flash[:notice]="Hi #{user.username} you are logged on"
        end
else
  redirect_to login_url, :alert => "Invalid user/password combination"
end
end

  def destroy
session[:user_id] = nil
  cookies.delete(:auth_token)
redirect_to store_url, :notice => "Logged out"
end
end




