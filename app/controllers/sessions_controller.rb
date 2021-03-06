class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      session[:before_mfa_user_id] = user.id
      # log_in user
      # redirect_to root_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Email is invalid"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url, notice: "Logged out!"
  end
end
