class StoreController < ApplicationController
  def index
    @products = Product.all
    if session[:user_id].present?
    @user = User.find_by_id(session[:user_id])
    @user_name = @user.username
    end
    end
  def search
p 1111111111111111111111111

p 2222222222222222222222222
   @products = Product.search params[:search]

  #redirect_to store_url
	#flash[:notice]="Please type something to search"

  end
end
