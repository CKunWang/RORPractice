module ApiV0
  class Signup < Grape::API

    desc 'user signup'
    params do
      requires :email, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
    end
    post "/signup/user" do

      raise DuplicateEmailError if User.has_duplicate_user? (params[:email])

      user = User.create!( :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation], :role=>'user')

    rescue ActiveRecord::RecordInvalid => e
      raise InvaildSignupError

    end

  end

end
