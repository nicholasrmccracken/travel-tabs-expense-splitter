class ExpensesController < ApplicationController
  # Ensure user is logged in before interacting with their trips
  before_action :authenticate_user!
  before_action :set_trip
  before_action :set_expense, only: %i[edit update destroy]

  # GET /trips/:trip_id/expenses
  # Displays a list of expenses for the current user's trips.
  def index
    # @expenses = @trip.expenses.includes(:users)
    @trips = current_user.trips.includes(:expenses)
  end

  # GET /trips/:trip_id/expenses/new
  # Initializes a new expense.
  def new
    # Only trip owner and participants can create an expense
    unless @trip.owner == current_user || @trip.users.include?(current_user)
      redirect_to @trip, alert: 'You are not authorized to add expenses for this trip.'
    end
    @expense = @trip.expenses.build
    @users = @trip.users.where.not(id: current_user.id) # Exclude current user
  end

  # POST /trips/:trip_id/expenses
  # Creates a new expense for a trip.
  def create
    @expense = @trip.expenses.build(expense_params.merge(creator_id: current_user.id))

    # Add participants to share the expense
    if @expense.save
      create_expense_participants
      redirect_to trip_path(@trip), notice: 'Expense created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /trips/:trip_id/expenses/:id/edit
  # Creates form to edit an existing expense for a trip.
  def edit
    return if @trip.owner == current_user || @trip.users.include?(current_user)

    redirect_to @trip, alert: 'You are not authorized to edit this expense.'
  end

  # PUT /trips/:trip_id/expenses/:id
  # Updates an expence once it has been edited.
  def update
    if @expense.update(expense_params)
      redirect_to trip_expense_path(@trip, @expense), notice: 'Expense updated successfully.'
    else
      flash.now[:alert] = 'Failed to update expense.'
      render :edit
    end
  end

  # DELETE /trips/:trip_id/expenses/:id
  # Deletes an expense if current user is the owner.
  def destroy
    if @trip.owner == current_user # only trip owner can delete an expense
      @expense.destroy
      redirect_to @trip, notice: 'Expense was successfully deleted.'
    else
      redirect_to trips_path, alert: 'You do not have permission to delete this trip.'
    end
  end

  # POST /trips/:trip_id/expenses/:id/leave
  # Remove user from expense
  def leave
    if @expense.users.include?(current_user)
      @expense.users.delete(current_user)
      redirect_to @trip, notice: 'You have left the expense.'
    else
      redirect_to @trip, alert: 'You are not part of this expense.'
    end
  end

  def update_shares
    participants_params = params[:participants]

    ActiveRecord::Base.transaction do
      participants_params.each do |participant_id, share_data|
        participant = @expense_participants.find_or_initialize_by(user_id: participant_id)
        participant.update!(
          share_type: share_data[:share_type],
          share_value: share_data[:share_value]
        )
      end
    end

    redirect_to expense_path(@expense), notice: 'Shares updated successfully.'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to expense_path(@expense), alert: e.message
  end

  private

  # Strong parameters for trip.
  #
  # @return [ActionController::Parameters] A hash of permitted parameters.
  def expense_params
    params.require(:expense).permit(:category, :description, :amount, :date, :share_type,
                                    expense_participants_attributes: %i[user_id share_value _destroy])
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_expense
    @expense = @trip.expenses.find(params[:id])
  end

  def create_expense_participants
    return unless params[:expense][:user_ids].present?

    params[:expense][:user_ids].each do |user_id|
      @expense.expense_participants.create(user_id: user_id) unless user_id.blank?
    end
  end
end
