class User < ActiveRecord::Base

	SUCCESS = 1
	ERR_BAD_CREDENTIALS = -1
	ERR_USER_EXISTS = -2
	ERR_BAD_PASSWORD = -4
	MAX_USERNAME_LENGTH = 128
	MAX_PASSWORD_LENGTH = 128

	def self.login(name, password)
		user = User.find_by_user(name)
		bool = true;

		if !user.instance_of?(User)
			bool = false;
		else 
		 	if(user.password == password)
		 		bool = true;
			else
				puts user.inspect
			 	bool = false;
			end	
		end
		if bool
			return user
		else return -1
		end
		# return user if user else nil
	end

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
			return user
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
