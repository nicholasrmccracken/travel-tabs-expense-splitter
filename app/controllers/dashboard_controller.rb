class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # Logic for the dashboard page
  end
end
