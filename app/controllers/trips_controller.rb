class TripsController < ApplicationController
  before_action :authenticate_user! # only logged-in users can create trips

  def new
    @trip = Trip.new
    @users = User.where.not(id: current_user.id) # current user is not a participant
  end

  def create
    @trip = current_user.trips.build(trip_params)
    if @trip.save
      add_participants(@trip, params[:trip][:participant_ids])
      redirect_to @trip, notice: 'Trip created!'
    else # trip could not be created
      @users = User.where.not(id: current_user.id) # reloads list of users to try again
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def destroy
    if @trip.user == current_user # only trip owner can delete trip
      @trip.destroy
      redirect_to trips_path, notice: 'Trip was successfully deleted.'
    else
      redirect_to trips_path, alert: 'You do not have permission to delete this trip.'
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :description, :start_date, :end_date)
  end

  # given trip and participants' user_ids, add participants to trip
  def add_participants(trip, participant_ids)
    participant_ids.reject(&:blank?).each do |user_id|
      trip.participants.create(user_id: user_id)
    end
  end
end
