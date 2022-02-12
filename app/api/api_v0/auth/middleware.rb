module ApiV0
  module Auth
    class Middleware < Grape::Middleware::Base
      def before
        if auth_provided?
		
          @env["api_v0.token"] = Authenticator.new(request, params).authenticate!

          user = User.find(@env["api_v0.token"].user_id) if @env["api_v0.token"].present?

          @env["api_v0.user"] ||= user if user.present?
        end
      end

      def request
        @request ||= ::Grape::Request.new(env)
      end

      def params
        @params ||= request.params
      end

      def auth_provided?
        request.headers["Token"].present?
      end
    end
  end
end
