module ApiV0
  module ExceptionHandlers

    def self.included(base)
      base.instance_eval do

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          rack_response({
            error: {
              code: 1001,
              message: e.message
            }
          }.to_json, e.status)
        end

        rescue_from ActiveRecord::RecordNotFound do
          rack_response({ 'message' => '404 Not found' }.to_json, 404)
        end

        route :any, '*path' do
          error!('404 Not Found', 404)
        end
      end
    end
  end

  class Error < Grape::Exceptions::Base
    attr :code, :text

    def initialize(opts={})
      @code    = opts[:code]   || 2000
      @text    = opts[:text]   || ''

      @status  = opts[:status] || 400
      @message = { error: { code: @code, message: @text } }
    end
  end

  class AuthorizationError < Error
    def initialize
      super code: 2001, text: 'Authorization failed', status: 401
    end
  end
  
  class LoginError < Error
    def initialize
      super code: 2002, text: 'Email or password wrong', status: 401
    end
  end
  
  class DuplicateEmailError < Error
    def initialize
      super code: 2003, text: 'Sign up with duplicate email', status: 500
    end
  end
  
  class InvaildSignupError < Error
    def initialize
      super code: 2004, text: 'Sign up with invalid data', status: 500
    end
  end
  
  class DuplicateLessonError < Error
    def initialize
      super code: 2005, text: 'Duplicate lesson', status: 500
    end
  end
  
  class InvalidDbOperationError < Error
    def initialize
      super code: 2006, text: 'Invalid db operation', status: 500
    end
  end

end
