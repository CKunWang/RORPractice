module ApiV0
  class LessonTransactions < Grape::API

    desc "Get available lessons"
    get "/lessons/available" do

      lessons = Lesson.user_available_lessons

      present lessons, with: ApiV0::Entities::Lesson
    end

    desc "Purchase a lesson."
    params do
      requires :id, type: Integer, desc: 'Lesson ID.'
    end
    post "/lessons/:id/purchase" do
	
	  authenticate!
	  
	  # Check lesson is available for user or not
	  lesson = Lesson.find_user_specified_lesson(params[:id])
      raise LessonNotFoundError if lesson.blank?

      # Check if user had bought same lesson
      raise DuplicateTransactionError if LessonTransaction.has_duplicate_lesson? current_user.id, lesson.id

	  #utc_expired_time = Time.now.utc + lesson.expired_days.minutes
      utc_expired_time = Time.now.utc + lesson.expired_days.days
      transaction = LessonTransaction.create(:user => current_user, :lesson => lesson, :currency => lesson.currency, :price => lesson.price, :expired_time => utc_expired_time)

      if transaction
        present transaction, with: ApiV0::Entities::LessonTransaction
      else
        raise StandardError, $!
      end
    end



    desc "get purchased lesson"
    get "/lessons/purchased" do
	
	  authenticate!
	  
	  transaction_records = LessonTransaction.get_lesson_transaction_records(current_user.id, params)
	  
	  lesson_ids = transaction_records.map {|record| record.lesson_id }

      lesson_ids = lesson_ids.uniq

      lessons = Lesson.where(id: lesson_ids)

      data = { :transaction_records => transaction_records, :lessons => lessons }

      present data, with: ApiV0::Entities::PurchasedLesson

      
    end

  end
end
