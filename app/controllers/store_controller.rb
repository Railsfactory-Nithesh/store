class StoreController < ApplicationController
  def index
    @products = Product.all
    if session[:user_id].present?
    @user = User.find_by_id(session[:user_id])
    @user_name = @user.username
    end
  end
end
