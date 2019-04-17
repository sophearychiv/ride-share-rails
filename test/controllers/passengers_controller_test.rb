require "test_helper"

describe PassengersController do
  let(:passenger) {
    Passenger.create name: "sample name", phone_num: "123", trip_id: nil
  }
  let(:invalid_id) {
    "INVALID ID"
  }
  describe "index" do
    it "can get index for all passengers" do
      get passengers_path
      must_respond_with :success
    end

    it "can get to the root path" do
      get root_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid passenger" do
      get passenger_path(passenger.id)
      must_respond_with :success
    end

    it "will redirect for an invalid passenger" do
      get passenger_path(invalid_id)
      must_respond_with :redirect
    end
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "new" do
    it "can get to the new task page" do
      get new_passenger_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do
      passenger_hash = {
        passenger: {
          name: "new passenger",
          phone_num: "321",
          trip_id: nil,
        },
      }
    end
  end

  describe "destroy" do
    # Your tests go here
  end
end
