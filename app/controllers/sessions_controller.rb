class SessionsController < ApplicationController
  layout 'login'
  def new
    @user = User.new
  end

  def destroy
    helpers.logout

    redirect_to login_path
  end

  def create
    @user = User.find_by(email: params[:email])

    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to store_index_path
    else
      message = "Credentials wrongs!!"
      redirect_to login_path, notice: message
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password_digest)
  end
end