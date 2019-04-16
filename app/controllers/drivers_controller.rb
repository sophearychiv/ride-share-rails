class DriversController < ApplicationController
  def index
    @drivers = Driver.all.order(:id)
  end

  def show
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to drivers_path
    end
  end

  def new
    @driver = Driver.new(trip_id: nil)
  end

  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      redirect_to driver_path(@driver.id)
    else
      render :new
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :trip_id)
  end
end
