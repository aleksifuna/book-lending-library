require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should not save user without password" do
    user = User.new(first_name: "John", last_name: "Doe", email_address: "john@example.com")
    assert_not user.save, "Saved the user without a password"
  end
end