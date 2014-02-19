class User < ActiveRecord::Base

	SUCCESS = 1
	ERR_BAD_CREDENTIALS = -1
	ERR_USER_EXISTS = -2
	ERR_BAD_PASSWORD = -4
	MAX_USERNAME_LENGTH = 128
	MAX_PASSWORD_LENGTH = 128

	#login function looks for existing user with same name and compares passwords
	# if successful, return 1, else return -1.
	#@params name, password
	#output = -1 (error) or USER

	def self.login(name, password)
		user = User.find_by_user(name)
		bool = true;

		if !user.instance_of?(User)
			bool = false;
		else 
		 	if(user.password == password)
		 		bool = true;
		 		user.count += 1
		 		user.save()
			else
			 	bool = false;
			end	
		end
		if bool
			return SUCCESS
		else return -1
		end
		# return user if user else nil
	end

	#this is the function that adds a user to the existing users. It does this by first making
	#sure that there is no other user with the same name. It also checks certain constraints
	# to make sure input is valid.
	#@params: name, password
	#output: [-2,-4] || 1

	def self.signup(name, password)
		if (name.length > MAX_USERNAME_LENGTH || name.length < 1)
			user = -3
			return user
		end
		if (password.length > MAX_PASSWORD_LENGTH || password.length <1)
			user = -4
			return user
		end
		if !User.find_by_user(name)
			user = User.new(user: name, password: password)
			user.count = 1
			user.save()
			return SUCCESS
		else user = -2
			return user
		end
		return
	end

	def self.TESTAPI_resetFixture
		User.delete_all
		return SUCCESS
	end

end
