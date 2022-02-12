module ApiV0
  module Entities
    class LessonTransaction < Entities::Base
      expose :id
      expose :user_id
      expose :lesson_id
	  expose :currency
	  expose :price
	  expose :expired_time
      expose :created_at, format_with: :iso8601
      expose :expired_time, format_with: :iso8601
    end
  end
end
