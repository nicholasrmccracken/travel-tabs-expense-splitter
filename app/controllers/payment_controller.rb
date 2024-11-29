class PaymentsController < ApplicationController
  before_action :set_trip
  before_action :set_user

  # look up leaguer based on user
  def new
    @leaguer = @trip.leaguers.find_by(user: @user)
  end

  # Record payment made by user
  def create
    leaguer = @trip.leaguers.find_by(user: @user)
    payment_amount = params[:payment_amount].to_f

    if leaguer.make_payment(payment_amount)
      redirect_to trip_path(@trip), notice: 'Payment recorded successfully!'
    else
      flash[:alert] = leaguer.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  # Retrieves trip object
  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  # Sets curent user of applictation to db user
  def set_user
    @user = current_user
  end
end
