class TripsController < ApplicationController
  def index
    @trips = Trip.all.order(:id)
  end

  def show
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to trips_path
    end
  end

  def new
    @trip = Trip.new(passenger_id: nil, driver_id: nil)
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to trip_path(@trip.id)
    else
      render :new
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost)
  end
end
