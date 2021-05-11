require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "should not save user without username" do
    user = User.new
    # byebug
    assert_not user.save, "Saved the user without a username"
  end
end
