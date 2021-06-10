module ApplicationHelper
  include Pagy::Frontend

  def logged_id?
    !!session[:user_id]
  end

  def logout
    session.delete(:user_id)
  end
end
