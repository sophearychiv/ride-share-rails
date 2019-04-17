class TripsController < ApplicationController
  def index
    @trips = Trip.all.order(:id)
  end

  def show
    if params[:passenger_id]
      @trip = Trip.find_by(passenger: Passenger.find_by(id: params[:passenger_id]))
    elsif params[:driver_id]
      @trip = Trip.find_by(driver: Driver.find_by(id: params[:driver_id]))
    else
      @trip = Trip.find_by(id: params[:id])
    end

    if @trip.nil?
      head :not_found
    end
  end

  # def new
  #   @trip = Trip.new(passenger_id: Passenger.find_by(id: params[:passenger_id]), driver_id: Driver.find_by(availability: true))
  # end

  def create
    @trip = Trip.new(passenger_id: Passenger.find_by(id: params[:passenger_id]), driver_id: Driver.find_by(availability: true).id)
    if @trip.save
      redirect_to passenger_trip_path(@trip.id)
    else
      render :new
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
