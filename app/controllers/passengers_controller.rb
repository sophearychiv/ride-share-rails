class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all.order(:id)
  end

  def show
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      redirect_to passengers_path
    end
  end

  def new
    @create_passenger = Passenger.new(trip_id: nil)
  end

  def create
    passenger = Passenger.new(passenger_params)
    if passenger.save
      redirect_to passenger_path(passenger.id)
    else
      render :new
    end
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num, :trip_id)
  end
end
