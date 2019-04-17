require "test_helper"

describe DriversController do
  let (:driver) {
    Driver.create name: "Jane Doe", vin: "12345678901234567"
  }
  describe "index" do
    it "can get index" do
      # Your code here
      get drivers_path
      must_respond_with :success
    end
  end

  describe "show" do
    # Your tests go here

  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "new" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
