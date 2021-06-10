class SessionsController < ApplicationController
  layout 'login'
  skip_before_action :authenticate_user, except: [:destroy]
  skip_before_action :previous_cart, except: [:destroy]

  def new
    @user = User.new
  end

  def reset_session
    session.delete(:is_admin)
    session.delete(:user_id)
    session.delete(:cart_id)
    session.delete(:count_food)
  end

  def destroy
    helpers.logout

    reset_session
    redirect_to login_path
  end

  def create
    reset_session
    @user = User.find_by(email: params[:email])

    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      cart_pending = Cart.find_by(user_id: @user.id, pending: true)
      if cart_pending
        session[:cart_id] = cart_pending.id
        session[:count_food] = LineItem.where(cart_id: cart_pending.id).count
      end

      if @user.is_admin?
        redirect_to foods_path
      else
        redirect_to store_index_path
      end

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