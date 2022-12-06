require "test_helper"

class BaggagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get baggages_index_url
    assert_response :success
  end
end
