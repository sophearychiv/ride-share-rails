require "test_helper"

describe TripsController do
  let (:passenger) {
    Passenger.create(name: "Jo Doe", phone_num: "204 950 3456")
  }
  let (:driver) {
    Driver.create(name: "Jan Doe", vin: "12345678901234567", availability: true)
  }
  let (:trip) {
    Trip.create(date: DateTime.now.to_date,
                rating: nil,
                cost: 45.50,
                driver_id: driver.id,
                passenger_id: passenger.id)
  }

  describe "show" do
    passenger = Passenger.first
    # Your tests go here
    it "should be 200 OK to show an existing valid trip from the passenger's view page" do
      get passenger_trip_path(passenger.id, trip.id)
      must_respond_with :success
    end

    it "should be 200 OK to show an existing valid trip from the driver's view page" do
      get driver_trip_path(driver.id, trip.id)
      must_respond_with :success
    end

    it "shows 404 not found with an invalid trip" do
      invalid_trip_id = -1
      get passenger_trip_path(passenger.id, invalid_trip_id)
      must_respond_with :not_found

      get driver_trip_path(driver.id, invalid_trip_id)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
    it "allows passenger to rate the trip and doesn't change anything else" do
      trip_to_rate = trip

      updated_rating_input = {
        trip: {
          date: trip.date,
          rating: 3,
          cost: trip.cost,
          driver_id: trip.driver_id,
          passenger_id: trip.passenger_id,
        },
      }

      expect {
        patch passenger_trip_path(passenger.id, trip_to_rate.id), params: updated_rating_input
      }.wont_change "Trip.count"

      must_respond_with :redirect
      must_redirect_to passengers_path

      trip_to_rate.reload
      expect(trip_to_rate.date).must_equal updated_rating_input[:trip][:date]
      expect(trip_to_rate.rating).must_equal updated_rating_input[:trip][:rating]
      expect(trip_to_rate.cost).must_equal updated_rating_input[:trip][:cost]
      expect(trip_to_rate.driver_id).must_equal updated_rating_input[:trip][:driver_id]
      expect(trip_to_rate.passenger_id).must_equal updated_rating_input[:trip][:passenger_id]
    end

    it "returns 404 not_found when user tries to rate the trip with invalid rating " do
      trip_to_rate = trip

      invalid_rating_input = {
        trip: {
          date: trip.date,
          rating: -1,
          cost: trip.cost,
          driver_id: trip.driver_id,
          passenger_id: trip.passenger_id,
        },
      }
      expect {
        patch passenger_trip_path(trip.passenger_id, trip.id), params: invalid_rating_input
      }.wont_change "Trip.count"

      must_respond_with :not_found
      trip_to_rate.reload
      expect(trip_to_rate.date).must_equal invalid_rating_input[:trip][:date]
      expect(trip_to_rate.rating).must_equal nil
      expect(trip_to_rate.cost).must_equal invalid_rating_input[:trip][:cost]
      expect(trip_to_rate.driver_id).must_equal invalid_rating_input[:trip][:driver_id]
      expect(trip_to_rate.passenger_id).must_equal invalid_rating_input[:trip][:passenger_id]
    end
  end

  describe "create" do
    # Your tests go here

    it "passenger can create a new trip" do
      driver
      passenger
      # p "show passenger #{passenger}"
      trip_to_create = {
        trip: {
          passenger_id: passenger.id,
          driver_id: driver.id,
        },
      }

      expect {
        post passenger_trips_path(passenger.id), params: trip_to_create
      }.must_change "Trip.count", 1
    end

    # must_respond_with :redirect
    # must_redirect_to passenger_trip_path(passenger_id, trip.id)

    # new_trip = Trip.find_by(passenger_id: passenger.id)
    # expect(new_trip).wont_be_nil
    # expect(new_trip.date).must_equal Date.today
    # expect(new_trip.passenger_id).must_equal passenger_id
    # expect(new_trip.driver_id).must_equal driver.id
    # expect(new_trip.rating).must_be_nil
  end

  describe "destroy" do
    # Your tests go here
  end
end
