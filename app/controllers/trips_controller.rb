class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: %i[show edit update destroy leave participants]
  before_action :authorize_participant, only: %i[show leave]

  # GET /trips
  # Displays a list of trips for the current user.
  def index
    @trips = current_user.trips
  end

  # GET /trips/:id
  # Displays a specific trip.
  def show
    @total_expenses = @trip.expenses.sum(:amount)
  end

  # GET /trips/new
  # Initializes a new trip and loads users for participant selection.
  def new
    @trip = Trip.new
    @expense = @trip.expenses.build
  end

  # POST /trips
  # Creates a new trip and adds participants.
  def create
    @trip = current_user.owned_trips.build(trip_params.except(:participant_emails))

    if @trip.save
      @trip.participants.create(user: current_user)
      add_participants(@trip, params[:trip][:participant_emails])
      redirect_to @trip, notice: 'Trip created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /trips/:id/edit
  # Creates a form to edit an existing trip.
  def edit
    if @trip.owner != current_user # only trip owner can edit trip # rubocop:disable Style/GuardClause
      redirect_to trips_path, alert: 'You do not have permission to edit this trip.'
    end
  end

  # PUT /trips/:id
  # Updates trip once it has been edited.
  def update
    if @trip.owner == current_user
      if @trip.update(trip_params.except(:participant_emails))
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
    if @trip.owner == current_user # only trip owner can delete trip
      if @trip.destroy
        redirect_to trips_path, notice: 'Trip was successfully deleted.'
      else
        redirect_to trips_path, alert: 'Failed to delete trip.'
      end
    else
      redirect_to trips_path, alert: 'You do not have permission to delete this trip.'
    end
  end

  # POST /trips/:trip_id/
  # Removed participant from trip.
  def leave
    @trip.users.delete(current_user)
    redirect_to trips_path, notice: 'You have left the trip.'
  end

  private

  # Strong parameters for trip.
  def trip_params
    params.require(:trip).permit(:name, :description, :start_date, :end_date, participant_emails: [])
  end

  # Sets the trip based on the ID parameter
  def set_trip
    @trip = Trip.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to trips_path, alert: 'Trip not found.'
  end

  def authorize_participant
    return if @trip.participants.exists?(user_id: current_user.id)

    redirect_to trips_path, alert: 'You do not have permission to view this trip.'
  end

  # Adds participants to the trip.
  #
  # @param trip [Trip] The trip to add participants to.
  # @param participant_ids [Array<Integer>] Array of user IDs to add as participants.
  def add_participants(trip, participant_emails)
    return unless participant_emails.present? || trip.owner.present?

    participant_emails ||= []
    participant_emails << trip.owner.email if trip.owner && participant_emails.include?(trip.owner.email)

    valid_users = User.where(email: participant_emails)

    valid_users.each do |user|
      trip.participants.find_or_create_by(user_id: user.id)
    end
  end
end
