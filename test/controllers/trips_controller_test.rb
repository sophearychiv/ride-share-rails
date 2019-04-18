require "test_helper"

describe TripsController do
  let (:trip) {
    Trip.create(driver_id: Driver.create(name: "Jan Doe", vin: "12345678901234567").id,
                passenger_id: Passenger.create(name: "Jo Doe", phone_num: "204 950 3456"),
                date: DateTime.now.to_date)
  }

  describe "show" do
    # Your tests go here
    it "should be 200 OK to show an existing valid trip" do
      valid_trip_id = trip.id
      get trip_path(valid_trip_id)
      must_respond_with :success
    end
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
