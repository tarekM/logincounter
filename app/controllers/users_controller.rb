class UsersController < ApplicationController
  
  def index
  	@users = User.all
  end

  def login
  	@usershell = User.login(params[:user], params[:password])
  	if @usershell > 0
  		@user = User.where(:user => params[:user]).first
  		#render json: {:count => @res.count,:errCode => 1}
  	else 
  		@user = @usershell

  	end
  end

  def add
  	@usershell = User.signup(params[:user], params[:password])
  	if @usershell > 0
  		@user = User.where(:user => params[:user]).first
  		#render json: {:count => @res.count, :errCode => 1}
  		#return @user
  		#render :add
  	else
  		@user = @usershell 
  		#return @user#render json: {:errCode => @user}
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
