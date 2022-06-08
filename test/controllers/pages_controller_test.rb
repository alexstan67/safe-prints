require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "should get home" do
    get pages_home_url
    assert_response :success
  end
>>>>>>> 6d1b1f4fc7320ebf1fbb8d72202c902fb13c1404
end
