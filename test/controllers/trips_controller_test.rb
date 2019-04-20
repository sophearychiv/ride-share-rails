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
    it "can get the edit page for an existing trip" do
      trip
      get edit_trip_path(trip.id)
      must_respond_with :success
    end

    it "will return 404 not_found if trying to edit an invalid trip" do
      get edit_trip_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "allows passenger to rate the trip on passenger's show page and doesn't change anything else" do
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
        patch passenger_trip_path(trip.passenger_id, trip_to_rate.id), params: updated_rating_input
      }.wont_change "Trip.count"

      must_respond_with :redirect
      must_redirect_to passenger_trip_path(trip_to_rate.passenger.id, trip_to_rate.id)

      trip_to_rate.reload
      expect(trip_to_rate.date).must_equal updated_rating_input[:trip][:date]
      expect(trip_to_rate.rating).must_equal updated_rating_input[:trip][:rating]
      expect(trip_to_rate.cost).must_equal updated_rating_input[:trip][:cost]
      expect(trip_to_rate.driver_id).must_equal updated_rating_input[:trip][:driver_id]
      expect(trip_to_rate.passenger_id).must_equal updated_rating_input[:trip][:passenger_id]
    end

    it "allows the user to edit the trip on the trip's show page" do
      trip_to_update = trip
      user_input = {
        trip: {
          date: Date.today,
          cost: 50.50,
          driver_id: trip_to_update.driver_id,
          passenger_id: trip_to_update.passenger_id,
          rating: 5.0,
        },
      }

      expect {
        patch trip_path(trip_to_update.id), params: user_input
      }.wont_change "Trip.count"

      trip_to_update.reload
      must_respond_with :redirect
      must_redirect_to passenger_trip_path(trip_to_update.passenger_id, trip_to_update.id)

      expect(trip_to_update.date).must_equal user_input[:trip][:date]
      expect(trip_to_update.rating).must_equal user_input[:trip][:rating]
      expect(trip_to_update.cost).must_equal user_input[:trip][:cost]
      expect(trip_to_update.driver_id).must_equal user_input[:trip][:driver_id]
      expect(trip_to_update.passenger_id).must_equal user_input[:trip][:passenger_id]
    end

    it "returns bad_request when user tries to rate the trip with invalid rating " do
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

      must_respond_with :bad_request
      trip_to_rate.reload
      expect(trip_to_rate.date).must_equal invalid_rating_input[:trip][:date]
      expect(trip_to_rate.rating).must_be_nil
      expect(trip_to_rate.cost).must_equal invalid_rating_input[:trip][:cost]
      expect(trip_to_rate.driver_id).must_equal invalid_rating_input[:trip][:driver_id]
      expect(trip_to_rate.passenger_id).must_equal invalid_rating_input[:trip][:passenger_id]
    end
  end

  describe "create" do
    it "passenger can create a new trip" do
      driver
      passenger
      trip_to_create = {
        trip: {
          passenger_id: passenger.id,
          driver_id: driver.id,
        },
      }

      expect {
        post passenger_trips_path(passenger.id), params: trip_to_create
      }.must_change "Trip.count", 1

      new_trip = Trip.where(passenger_id: passenger.id).last
      expect(new_trip).wont_be_nil
      expect(new_trip.date).must_equal Date.today
      expect(new_trip.passenger_id).must_equal passenger.id
      expect(new_trip.driver_id).must_equal driver.id
      expect(new_trip.rating).must_be_nil

      must_respond_with :redirect
      must_redirect_to passenger_trip_path(passenger.id, new_trip.id)
    end

    it "changes the associated driver's availability to false when a new trip is created" do
      driver
      passenger
      trip_to_create = {
        trip: {
          passenger_id: passenger.id,
          driver_id: driver.id,
        },
      }

      expect {
        post passenger_trips_path(passenger.id), params: trip_to_create
      }.must_change "Trip.count", 1

      new_trip = Trip.where(passenger_id: passenger.id).last
      expect(new_trip.driver.availability).must_equal false
    end

    it "must respond with 404 not_found if trying to create a trip with invalid data" do
      passenger = Passenger.first
      invalid_trip = {
        trip: {
          date: Date.today,
          rating: nil,
          cost: 45.50,
          driver_id: nil,
          passenger_id: -1,
        },
      }

      expect {
        post passenger_trips_path(passenger.id), params: invalid_trip
      }.wont_change "Trip.count"

      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "can delete the trip" do
      trip
      expect {
        delete trip_path(trip.id)
      }.must_change "Trip.count", -1
    end

    it "can delete the trip when the passenger is deleted" do
      passenger
      trip
      expect {
        delete passenger_path(passenger.id)
      }.must_change "Trip.count", -1
    end

    it "can delete the trip when the driver is deleted" do
      driver
      trip
      expect {
        delete driver_path(driver.id)
      }.must_change "Trip.count", -1
    end

    it "returns 404 not_found if the trip is invalid" do
      invalid_trip_id = -1
      delete trip_path(invalid_trip_id)
      must_respond_with :not_found
    end
  end
end
