require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  	SUCCESS = 1
	ERR_BAD_CREDENTIALS = -1
	ERR_USER_EXISTS = -2
	ERR_BAD_USERNAME = -3
	ERR_BAD_PASSWORD = -4
	MAX_USERNAME_LENGTH = 128
	MAX_PASSWORD_LENGTH = 128

	test "reset" do
		out = User.TESTAPI_resetFixture 
		assert out == SUCCESS
	end

	test "signup succeeds" do
		val = User.signup("test1", "test")
		assert val == SUCCESS
	end

end
