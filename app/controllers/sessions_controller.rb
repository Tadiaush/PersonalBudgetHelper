class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user
      login_user(user)
      redirect_to dashboard_path, notice: 'Successfully logged in!'
    else
      # For simplicity, create a new user if email doesn't exist
      user = User.create!(email: params[:email], name: params[:email].split('@').first)
      login_user(user)
      redirect_to dashboard_path, notice: 'Account created and logged in!'
    end
  end

  def destroy
    logout_user
    redirect_to login_path, notice: 'Successfully logged out!'
  end
end