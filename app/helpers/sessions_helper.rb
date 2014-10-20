module SessionsHelper
  def user_signed_in?
    !current_user.nil?
  end
  
  def current_user
    User.find_by_id session[:user_id]
  end
end
