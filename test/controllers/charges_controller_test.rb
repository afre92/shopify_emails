require 'test_helper'

class ChargesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get charges_create_url
    assert_response :success
  end

  test "should get cancel" do
    get charges_cancel_url
    assert_response :success
  end

  test "should get activate" do
    get charges_activate_url
    assert_response :success
  end

end
