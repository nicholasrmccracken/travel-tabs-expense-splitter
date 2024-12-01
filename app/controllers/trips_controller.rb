class TripsController < ApplicationController
  # Ensure user is logged in before interacting with their trips
  before_action :authenticate_user!

  # GET /trips
  # Displays a list of trips for the current user.
  def index
    @trips = current_user.trips + current_user.owned_trips
  end

  # GET /trips/:id
  # Displays a specific trip.
  def show
    @trip = Trip.find(params[:id])
  end

  # GET /trips/new
  # Initializes a new trip and loads users for participant selection.
  def new
    @trip = Trip.new
    @users = User.where.not(id: current_user.id) # current user is not a participant
  end

  # POST /trips
  # Creates a new trip and adds participants.
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

  # GET /trips/:id/edit
  # Creates a form to edit an existing trip.
  def edit
    if @trip.user != current_user # only trip owner can edit trip # rubocop:disable Style/GuardClause
      redirect_to trips_path, alert: 'You do not have permission to edit this trip.'
    end
  end

  # PUT /trips/:id
  # Updates trip once it has been edited.
  def update
    if @trip.user == current_user
      if @trip.update(trip_params)
        redirect_to @trip, notice: 'Trip was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to trips_path, alert: 'You do not have permission to update this trip.'
    end
  end

  # DELETE /trips/:id
  # Deletes a trip if the current user is the owner.
  def destroy
    if @trip.user == current_user # only trip owner can delete trip
      @trip.destroy
      redirect_to trips_path, notice: 'Trip was successfully deleted.'
    else
      redirect_to trips_path, alert: 'You do not have permission to delete this trip.'
    end
  end

  # Removed participant from trip.
  def leave
    if @trip.users.include?(current_user)
      @trip.users.delete(current_user)
      redirect_to trips_path, notice: 'You have left the trip.'
    else
      redirect_to trips_path, alert: 'You do not have permission to leave this trip.'
    end
  end

  private

  # Strong parameters for trip.
  #
  # @return [ActionController::Parameters] A hash of permitted parameters.
  def trip_params
    params.require(:trip).permit(:name, :description, :start_date, :end_date)
  end

  # Adds participants to the trip.
  #
  # @param trip [Trip] The trip to add participants to.
  # @param participant_ids [Array<Integer>] Array of user IDs to add as participants.
  def add_participants(trip, participant_ids)
    participant_ids.reject(&:blank?).each do |user_id|
      trip.participants.create(user_id: user_id)
    end
  end
end
