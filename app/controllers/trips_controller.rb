class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
    end
  end

  def create
    driver = Driver.find_by(availability: true)
    if driver
      @trip = Trip.create(
        passenger_id: Passenger.find_by(id: params[:passenger_id]).id,
        driver_id: driver.id,
        cost: rand(1...100), date: Date.today,
      )
      driver.update(availability: false)
      redirect_to passenger_trip_path(params[:passenger_id], @trip.id)
    else
      head :not_found
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
    end
  end

  def update
    trip = Trip.find_by(id: params[:id])
    passenger_id = trip.passenger_id
    is_successful = trip.update(trip_params)
    if is_successful
      redirect_to passenger_trip_path(passenger_id, params[:id])
    else
      @trip = trip
      render :edit, status: :bad_request
    end
  end

  def destroy
    trip = Trip.find_by(id: params[:id])
    if trip.nil?
      head :not_found
    else
      passenger_id = trip.passenger_id
      trip.destroy
      redirect_to passenger_path(passenger_id)
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
