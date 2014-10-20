class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email params[:email]
    if user.try(:authenticate, params[:password])
      # signing in the user
      session[:user_id] = user.id
      flash[:success] = 'Welcome to Demo app!'
      redirect_to root_path
    else
      flash.now[:danger] = 'Wrong Email or Password.'
      render 'new'
    end
  end
  
  def destroy
    # signing out user
    reset_session
    flash[:success] = 'You have successfully signed out!'
    redirect_to root_path
  end
end
