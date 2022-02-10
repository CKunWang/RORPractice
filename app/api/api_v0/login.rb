module ApiV0
  class Login < Grape::API
    desc 'user login'
    post "/login" do

      user = User.find_by(email: params[:email])

      raise LoginError if user.blank? || !user.valid_password?(params[:password])

      puts "auth success generate token #{user.id}"
	  
	  token = ApiAccessToken.create(user_id: user.id, expired_time: Time.now.utc + 1.hours)
	  
	  token.key

    end

  end

end

