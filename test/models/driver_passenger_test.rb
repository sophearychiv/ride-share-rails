require "test_helper"

describe DriverPassenger do
  let(:driver_passenger) { DriverPassenger.new }

  it "must be valid" do
    value(driver_passenger).must_be :valid?
  end
end
