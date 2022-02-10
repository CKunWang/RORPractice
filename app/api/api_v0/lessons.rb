module ApiV0
  class Lessons < Grape::API
    before { authenticate_admin! }

    desc "Create new lesson"
    params do
      requires :subject, type: String
      requires :currency, type: String
      requires :price, type: Integer
      requires :lesson_type, type: String
      requires :is_available, type: Boolean
      requires :url, type: String
      requires :description, type: String
      requires :expired_days, type: Integer
    end
    post "/lessons" do
	
      lesson = Lesson.new(declared(params, include_missing: false))
	  
	  raise DuplicateLessonError if lesson.has_duplicate_lesson?

      if lesson.save
        present lesson, with: ApiV0::Entities::Lesson
      else
        raise StandardError, $!
      end
    end
	
	desc "read all lessons"
    get "/lessons" do
      lessons = Lesson.all

      present lessons, with: ApiV0::Entities::Lesson
    end


    desc "Update a lesson"
    params do
      requires :id, type: Integer
      requires :subject, type: String
      requires :currency, type: String
      requires :price, type: Integer
      requires :lesson_type, type: String
      requires :is_available, type: Boolean
      requires :url, type: String
      requires :description, type: String
      requires :expired_days, type: Integer
    end
    put "/lessons/:id" do
      lesson = Lesson.find(params[:id])
	  
	  lesson.subject = params[:subject]
	  
	  raise DuplicateLessonError if lesson.has_duplicate_lesson?

      if lesson.update(declared(params, include_missing: false))
        present lesson, with: ApiV0::Entities::Lesson
      else
        raise StandardError, $!
      end

    end


    desc "Delete a lesson."
    params do
      requires :id, type: Integer, desc: 'Lesson ID.'
    end
    delete "/lessons/:id" do
	
      lesson = Lesson.find(params[:id])

      if lesson.destroy
        present lesson, with: ApiV0::Entities::Lesson
      else
        raise StandardError, $!
      end
    end

  end
end
