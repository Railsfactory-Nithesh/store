class ApplicationController < ActionController::Base
  protect_from_forgery
  


def current_user
  @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
end


def check_user
  
if !session[:user_id].present?
redirect_to '/login'
end
end
def check_admin
  if session[:is_admin] == false
    redirect_to store_path
    flash[:notice] = "You are not authorize to access this page"
  end
end

private
def current_cart

Cart.find(session[:cart_id])

rescue ActiveRecord::RecordNotFound
cart = Cart.create
session[:cart_id] = cart.id
cart
end
end
