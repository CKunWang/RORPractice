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
	  raise DuplicateLessonError if Lesson.has_duplicate_lesson? (params[:subject])
	  
	  begin
        present lesson, with: ApiV0::Entities::Lesson if lesson.save
	  rescue 
	    raise InvalidDbOperationError
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
	  raise DuplicateLessonError if lesson.has_duplicate_lesson_without_self? (params[:subject])
	  
	  begin
        present lesson, with: ApiV0::Entities::Lesson if lesson.update(declared(params, include_missing: false))
	  rescue 
	    raise InvalidDbOperationError
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
