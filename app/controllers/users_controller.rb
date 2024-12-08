class UsersController < ApplicationController
  def verify_email
    email = params[:email]
    user_exists = User.exists?(email: email)
    render json: { exists: user_exists }
  end
  def index
    @users = User.where.not(id: current_user.id) # Exclude the current user
  end
end
