class TripsController < ApplicationController
  # def index
  #   @trips = Trip.all.order(:id)
  # end

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

  # def new
  #   @trip = Trip.new(passenger_id: Passenger.find_by(id: params[:passenger_id]), driver_id: Driver.find_by(availability: true))
  # end

  def create
    driver = Driver.find_by(availability: true)
    if driver
      @trip = Trip.create(
        passenger_id: Passenger.find_by(id: params[:passenger_id]).id,
        driver_id: driver.id,
        # driver_id: Driver.find_by(availability: true).id,
        cost: rand(1...100), date: Date.today,
      )
      # if @trip.save
      # redirect_to passenger_trip_path(params[:passenger_id])
      # raise
      driver.update(availability: false) # added tests
      redirect_to passenger_trip_path(params[:passenger_id], @trip.id)
    else
      # @trip.nil?
      head :not_found
      # raise
    end

    # redirect_to "/passengers/#{params[:passenger_id]}/trips/#{@trip.id}"

    # else
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
  end

  def update
    trip = Trip.find_by(id: params[:id])

    if params[:passenger_id]
      trip.rating = params[:trip][:rating]
      if trip.save
        redirect_to passenger_path(params[:id])
      end
    else
      is_successful = trip.update(trip_params)
      if is_successful
        redirect_to trip_path(trip.id)
      else
        # render :edit, status: :bad_request # need to write tests
        head :not_found
      end
    end
  end

  def destroy
    trip = Trip.find_by(id: params[:id])
    passenger_id = trip.passenger_id
    if trip.nil?
      head :not_found
      raise
    else
      trip.destroy
      redirect_to passenger_path(passenger_id)
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
