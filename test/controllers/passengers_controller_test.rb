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
    it "can get to edit page" do
      get edit_passenger_path(passenger.id)
      must_respond_with :success
    end
  end

  describe "update" do
    it "will update an existing passenger" do
      edit_input = {
        passenger: {
          name: "edited name",
          phone_num: "987",
        },
      }
      passenger_to_update = Passenger.create(name: "Will Update Name", phone_num: "999", trip_id: nil)

      expect {
        patch passenger_path(passenger_to_update.id), params: edit_input
      }.wont_change "Passenger.count"
      must_respond_with :redirect
      passenger_to_update.reload
      expect(passenger_to_update.name).must_equal edit_input[:passenger][:name]
      expect(passenger_to_update.phone_num).must_equal edit_input[:passenger][:phone_num]
    end

    it "will return a bad request (400) when asked to update with invalid data" do
      edit_input = {
        passenger: {
          name: "",
          phone_num: 987,
        },
      }
      passenger_to_update = Passenger.create(name: "Will update name", phone_num: "999", trip_id: nil)

      expect {
        patch passenger_path(passenger_to_update.id), params: edit_input
      }.wont_change "Passenger.count"

      must_respond_with :bad_request
    end
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
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1
      test_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(test_passenger).wont_be_nil
      expect(test_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(test_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
    end
  end

  describe "destroy" do
    it "returns 404 if the book is not found" do
      delete passenger_path(invalid_id)
      must_respond_with :not_found
    end

    it "can delete a passenger" do
      new_passenger = Passenger.create(name: "new passenger", phone_num: "9999", trip_id: nil)
      expect {
        delete passenger_path(new_passenger.id)
      }.must_change "Passenger.count", -1

      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end
end
