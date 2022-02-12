module ApiV0
  module Entities
    class PurchasedLesson < Entities::Base

      expose :transaction_records, using: ApiV0::Entities::LessonTransaction
      expose :lessons, using: ApiV0::Entities::Lesson
    end
  end
end
