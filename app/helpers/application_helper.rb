module ApplicationHelper

  def logged_id?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if !!session[:user_id]
  end

  def logout
    session.delete(:user_id)
  end
end
