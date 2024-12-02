class ExpensesController < ApplicationController
  # Ensure user is logged in before interacting with their trips
  before_action :authenticate_user!
  before_action :set_trip
  before_action :set_expense, only: %i[show edit update destroy leave]

  # GET /trips/:trip_id/expenses
  # Displays a list of expenses for the current user's trips.
  def index
    @expenses = @trip.expenses.includes(:users)
  end

  # GET /trips/:trip_id/expenses/:id
  def show
  end

  # GET /trips/:trip_id/expenses/new
  # Initializes a new expense.
  def new
    # Only trip owner and participants can create an expense
    unless @trip.user == current_user || @trip.users.include?(current_user)
      redirect_to @trip, alert: 'You are not authorized to add expenses for this trip.'
    end
    @expense = @trip.expenses.build
    @users = @trip.users.where.not(id: current_user.id) # Exclude current user
  end

  # POST /trips/:trip_id/expenses
  # Creates a new expense for a trip.
  def create
    @expense = @trip.expenses.build(expense_params)
    @expense.user = current_user
    if @expense.save
      add_shared_users(@expense, params[:expense][:user_ids]) # add other users to share the expense
      redirect_to @trip, notice: 'Expense successfully added.'
    else
      @users = @trip.users.where.not(id: current_user.id)
      render :new, status: :unprocessable_entity
    end
  end

  # GET /trips/:trip_id/expenses/:id/edit
  # Creates form to edit an existing expense for a trip.
  def edit
    unless @trip.user == current_user || @trip.users.include?(current_user) # rubocop:disable Style/GuardClause
      redirect_to @trip, alert: 'You are not authorized to edit this expense.'
    end
  end

  # PUT /trips/:trip_id/expenses/:id
  # Updates an expence once it has been edited.
  def update
    if @expense.update(expense_params)
      redirect_to trip_expense_path(@trip, @expense), notice: 'Expense was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /trips/:trip_id/expenses/:id
  # Deletes an expense if current user is the owner.
  def destroy
    if @trip.user == current_user # only trip owner can delete an expense
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

  private

  # Strong parameters for trip.
  #
  # @return [ActionController::Parameters] A hash of permitted parameters.
  def expense_params
    params.require(:expense).permit(:description, :amount, :date, user_ids: [])
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_expense
    @expense = @trip.expenses.find(params[:id])
  end

  def add_shared_users(expense, user_ids)
    return if user_ids.blank? # no added users

    users = User.find(user_ids)
    expense.users << users
  end
end
