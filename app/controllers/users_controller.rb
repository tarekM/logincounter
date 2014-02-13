class UsersController < ApplicationController
  
  def index
  	@users = User.all
  end

  def login
  	@user = User.login(params[:user], params[:password])
  	if @user.instance_of?(User)
  		@user.count += 1
  		@user.save()
  		render json: {:errCode => 1}
  	else render json: {:errCode => @user}

  	end
  end

  def add
  	@user = User.signup(params[:user], params[:password])
  	if @user.instance_of?(User)
  		render json: {:count => @user.count, :errCode => 1}
  		return
  	else 
  		render json: {:errCode => @user}
  	end
  end



	def resetFixture
	  	User.TESTAPI_resetFixture
	  	render json: {:errCode => 1}
	end

	def unitTests
	  	@out = `ruby -Itest test/unit/user_test.rb`
	  	@total = Integer(@out.scan(/^\d+ tests,/).first.split.first)
	  	@failed = Integer(@out.scan(/\s\d+ failures,/).first.split.first)
	  	render json: {totalTests: @total, output: @out, nrFailed: @failed}
  	end
end
