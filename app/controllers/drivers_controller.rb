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
      render :new, status: :bad_request
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to drivers_path, :flash => { :error => "Driver id (#{params[:id]}) not found!" }
    end
  end

  def update
    driver = Driver.find_by(id: params[:id])
    if driver.nil?
      head :not_found
    else
      is_successful = driver.update(driver_params)
      if is_successful
        redirect_to driver_path(driver.id)
      else
        @driver = driver
        render :edit, status: :bad_request
      end
    end
  end

  def destroy
    driver = Driver.find_by(id: params[:id])
    if driver.nil?
      head :not_found
    else
      driver.trips.each do |trip|
        trip.destroy
      end
      driver.destroy
      redirect_to drivers_path
    end
  end

  def toggle_online
    driver = Driver.find_by(id: params[:id])

    if driver.nil?
      redirect_to drivers_path
    else
      is_successful = driver.update(driver_params)
      if is_successful
        redirect_to driver_path(driver.id)
      else
        redirect_to drivers_path
      end
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :availability)
  end
end
