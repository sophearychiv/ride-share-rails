require "test_helper"

describe PassengersController do
  describe "index" do
    it "can get index for all passengers" do
      get passengers_path
      must_respond_with :success
    end
    # Your tests go here
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
