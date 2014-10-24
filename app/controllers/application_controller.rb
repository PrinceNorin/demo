class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  protected
  
    def signed_in_user_check
      unless user_signed_in?
        flash[:danger] = 'Access denied. You need to signin to continue.'
        redirect_to signin_path
      end
    end
    
    def redirect_signed_in_user
      if user_signed_in?
        flash[:notice] = 'You are already signed in.'
        redirect_to root_path
      end
    end
end
