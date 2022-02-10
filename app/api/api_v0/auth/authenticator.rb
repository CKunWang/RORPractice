module ApiV0
  module Auth
    class Authenticator
      def initialize(request, params)
        @request = request
        @params  = params
      end

      def authenticate!
        check_token!
		@token
      end

      def token
        @token = ApiAccessToken.joins(:user).where(key: @request.headers["Token"]).where("expired_time > ?", Time.now.utc).first
      end

      def check_token!
        return @request.headers["Token"] unless token
      end
    end
  end
end
