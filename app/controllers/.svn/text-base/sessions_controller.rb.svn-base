class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      if user.role_id == 1
        redirect_to(admin_main_url, :notice => "Welcome Admin #{current_user.full_name}!")
      else
        redirect_to root_url, :notice => "Hi #{current_user.full_name}! Welcome to iConsign."
      end
    else
      flash[:notice] = "Invalid email or password."
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    # unless current_cart.empty?
      # if current_user.cart #user has an existing associated cart
        # @cart = current_user.cart
      # else #create new cart for the current user
        # @cart = current_user.create_cart(:user_id => current_user)
      # end
    # end
    redirect_to root_url, :notice => "Logged out!"
  end
end
