class TripsController < ApplicationController
  def index
    @trips = Trip.all.order(:id)
  end

  def show
    # if
    # @trip = Trip.find_by(passenger: Passenger.find_by(id: params[:passenger_id]))
    # elsif params[:driver_id]
    #   @trip = Trip.find_by(driver: Driver.find_by(id: params[:driver_id]))
    # else
    @trip = Trip.find_by(id: params[:id])
    # raise
    # end

    if @trip.nil?
      head :not_found
    end
  end

  def new
    @trip = Trip.new(passenger_id: Passenger.find_by(id: params[:passenger_id]), driver_id: Driver.find_by(availability: true))
  end

  def create
    @trip = Trip.create(passenger_id: Passenger.find_by(id: params[:passenger_id]).id, driver_id: Driver.find_by(availability: true).id, cost: rand(1...100), date: Date.today)
    # if @trip.save
    # redirect_to passenger_trip_path(params[:passenger_id])
    # raise
    redirect_to "/passengers/#{params[:passenger_id]}/trips/#{@trip.id}"
    # else
    if @trip.nil?
      head :not_found
      # raise
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
  end

  def update
    trip = Trip.find_by(id: params[:id])
    trip.rating = params[:trip][:rating]
    if trip.save
      redirect_to passengers_path
    else
      head :not_found
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
