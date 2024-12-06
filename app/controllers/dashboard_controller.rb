class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @trips = @user.trips.order(start_date: :asc) # Example: Fetch user's trips
    @friend_requests = @user.received_friend_requests.where(status: 'pending') # Example: Fetch pending friend requests
  end
end
