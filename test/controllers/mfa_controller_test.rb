require 'test_helper'

class MfaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mfa_index_url
    assert_response :success
  end

  test "should get new" do
    get mfa_new_url
    assert_response :success
  end

  test "should get create" do
    get mfa_create_url
    assert_response :success
  end

end
