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
	LONG_STRING = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

	test "try signup" do
		out = User.signup("user", "ilove162")
		assert out == SUCCESS
	end

	test "try login" do
		out1 = User.signup("user", "ilove162")
		out = User.login("user","ilove162")
		assert out == SUCCESS
	end

	test "bad username" do
		out = User.signup("","hello")
		assert out == ERR_BAD_USERNAME
	end

	test "bad password" do
		out = User.signup("newguy","")
		assert out == ERR_BAD_PASSWORD
	end

	test "signupexists" do
		out1 = User.signup("user","password")
		out = User.signup("user","password")
		assert out == ERR_USER_EXISTS
	end

	test "wrong password" do
		out = User.login("user","ihate162")
		assert out == ERR_BAD_CREDENTIALS
	end

	test "reset" do
		out = User.TESTAPI_resetFixture 
		assert out == SUCCESS
	end

	test "add multiple users" do
		out = User.signup("alan","turing")
		assert out == SUCCESS

		out = User.signup("brian","harvey")
		assert out == SUCCESS
	end

	test "long password" do
		out = User.signup("g",LONG_STRING)
		assert out == ERR_BAD_PASSWORD
	end

	test "long username" do
		out = User.signup(LONG_STRING,"pw")
		assert out == ERR_BAD_USERNAME
	end




end
