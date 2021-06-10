class AdminController < ApplicationController
  layout 'admin'
  before_action :require_user_is_admin

  def require_user_is_admin
    unless Current.user.is_admin?
      redirect_to store_index_url
    end
  end
end