module SessionsHelper
  def user_signed_in?
    !current_user.nil?
  end
  
  def current_user
    User.find_by_id session[:user_id]
  end
  
  def signing_in(user)
    session[:user_id] = user.id
  end
  
  def signing_out
    reset_session
  end
end
