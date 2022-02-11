module ApiV0
  class Login < Grape::API
    desc 'user login'
	params do
      requires :email, type: String
      requires :password, type: String
    end
    post "/login" do
	  
	  raise LoginError unless user = User.validate_user(params[:email], params[:password])
	  
	  token = ApiAccessToken.create(user_id: user.id, expired_time: Time.now.utc + Rails.configuration.token_expire_second.seconds)
	  
	  token.key

    end

  end

end

