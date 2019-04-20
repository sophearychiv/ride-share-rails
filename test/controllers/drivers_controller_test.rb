require "test_helper"

describe DriversController do
  let (:driver) {
    Driver.create(name: "Jane Doe",
                  vin: "12345678901234567",
                  availability: true)
  }
  let (:invalid_id) {
    "INVALID ID"
  }
  describe "index" do
    it "can get index path" do
      # Your code here
      get drivers_path
      must_respond_with :success
    end

    it "can get the root path" do
      get root_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "returns 200 OK to show an existing valid driver" do
      valid_driver_id = driver.id
      get driver_path(valid_driver_id)
      must_respond_with :success
    end

    it "will redirect for an invalid driver" do
      get driver_path(-1)
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

  describe "edit" do
    it "can get the edit page for an existing driver" do
      get edit_driver_path(driver.id)
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a non-existing driver" do
      get edit_driver_path(-1)
      must_respond_with :redirect
      must_redirect_to drivers_path
      expect(flash[:error]).must_equal "Driver id (-1) not found!"
    end
  end

  describe "update" do
    it "can update an existing driver" do
      driver = Driver.first
      driver_hash = {
        driver: {
          name: "Sam Chiv",
          vin: "12345678901234567",
        },
      }

      expect {
        patch driver_path(driver.id), params: driver_hash
      }.wont_change "Driver.count"

      must_respond_with :redirect
      must_redirect_to driver_path(driver.id)

      driver.reload
      expect(driver.name).must_equal driver_hash[:driver][:name]
      expect(driver.vin).must_equal driver_hash[:driver][:vin]
    end

    it "will return 404 not_found if given an invalid id" do
      driver
      invalid_id
      expect {
        patch driver_path(invalid_id)
      }.wont_change "Driver.count"
      must_respond_with :not_found
    end

    it "will return a bad request if given an invalid name" do
      starter_input = {
        name: "Jan Doe",
        vin: "12345678901234567",
      }

      driver = Driver.create(starter_input)

      test_driver = {
        driver: {
          name: "",
          vin: "1234567890123abc9",
        },
      }

      expect {
        patch driver_path(driver.id), params: test_driver
      }.wont_change "Driver.count"

      must_respond_with :bad_request
      driver.reload
      expect(driver.name).must_equal starter_input[:name]
      expect(driver.vin).must_equal starter_input[:vin]
    end

    it "will return a bad request if given an invalid vin" do
      starter_input = {
        name: "Jan Doe",
        vin: "1234567890123abc9",
      }

      driver = Driver.create(starter_input)

      test_driver = {
        driver: {
          name: "Jo Doe",
          vin: "",
        },
      }

      expect {
        patch driver_path(driver.id), params: test_driver
      }.wont_change "Driver.count"

      must_respond_with :bad_request
      driver.reload
      expect(driver.name).must_equal starter_input[:name]
      expect(driver.vin).must_equal starter_input[:vin]
    end
  end

  describe "new" do
    # Your tests go here
    it "can get a new driver page" do
      get new_driver_path
      must_respond_with :success
    end
  end

  describe "create" do
    # Your tests go here
    it "can create and save a new driver and redirect" do
      input_driver = {
        driver: {
          name: "Sandi Metz",
          vin: "1234567890123abc9",
        },
      }

      expect {
        post drivers_path, params: input_driver
      }.must_change "Driver.count", 1

      new_driver = Driver.find_by(name: input_driver[:driver][:name])
      expect(new_driver).wont_be_nil
      expect(new_driver.name).must_equal input_driver[:driver][:name]
      expect(new_driver.vin).must_equal input_driver[:driver][:vin]

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end

    it "will return a 400 bad request with an invalid driver" do
      test_driver = {
        driver: {
          name: "",
          vin: "1234567890123abc9",
        },
      }

      expect {
        post drivers_path, params: test_driver
      }.wont_change "Driver.count"

      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    # Your tests go here
    it "can delete a driver" do
      driver = Driver.first
      expect {
        delete driver_path(driver.id)
      }.must_change "Driver.count", -1

      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "returns 404 if the driver is not found" do
      invalid_id = " NOT A VALID ID"

      expect {
        delete driver_path(invalid_id)
      }.wont_change "Driver.count"

      must_respond_with :not_found
    end
  end

  describe "toggle_online" do
    it "changes the driver's availability" do
      driver = Driver.first
      driver_hash = {
        driver: {
          name: "Sam",
          vin: "12345678901234567",
          availability: false,
        },
      }

      expect {
        patch toggle_online_path(driver.id), params: driver_hash
      }.wont_change "Driver.count"

      driver.reload
      expect(driver.availability).must_equal false
      must_respond_with :redirect
      must_redirect_to driver_path(driver.id)
    end

    it "redirects to drivers_path if driver_id is invalid" do
      driver_hash = {
        driver: {
          name: "Sam",
          vin: "12345678901234567",
          availability: false,
        },
      }

      patch toggle_online_path(-1), params: driver_hash
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end
end
