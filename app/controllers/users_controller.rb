class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :check_user
  before_filter :check_admin,:only => [:index, :forgot_password] 
  
  
def check_admin
  if session[:is_admin] == false
    redirect_to store_path
    flash[:notice] = "You are not authorize to access this page"
  end
end

 def index
@users = User.order(:username)
respond_to do |format|
format.html # index.html.erb
format.xml { render :xml => @users }
end
end

  # GET /users/1
  # GET /users/1.json
  def show
     x = params[:id].to_i
   if x == session[:user_id]
   @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
    else
     redirect_to "/users/session[:user_id]/"
    end
    
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    x = params[:id].to_i
  
   if x == session[:user_id]
    @user = User.find(params[:id])
    else
     redirect_to "/users/#{session[:user_id]}/edit"
    end

    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user].merge!({commit_type: params[:commit]}))
    respond_to do |format|
      if @user.save
        
        format.html { redirect_to(users_url, 
        :notice => "User #{@user.username} was successfully created." ) }
        format.xml { render :xml => @user,
        :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors,
        :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
def update
@user = User.find(params[:id])
respond_to do |format|
if @user.update_attributes(params[:user].merge!({commit_type: params[:commit]}))
format.html { redirect_to(@user.is_admin ? users_url : user_path(@user),
:notice => "User #{@user.username} was successfully updated." ) }
format.xml { head :ok }
else
format.html { render :action => "edit" }
format.xml { render :xml => @user.errors,
:status => :unprocessable_entity }
end
end
end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  
  def forgot_password
    
  #     user = User.find_by_email_id(params[:email])
  #user.send_password_reset if user
  #redirect_to root_url, :notice => "Email sent with password reset instructions."
   
    
  end
  
  
 
  
  
  def reset_password
    user = User.find_by_email_id(params[:email_id])
    p 11111111111111111111111111111
    p user
    
    user.send_password_reset if user
  redirect_to store_url, :notice => "Email sent with password reset instructions."
    
    p 22222222222222222222222222222

    end
end
