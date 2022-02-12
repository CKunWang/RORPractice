class LessonTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  
  def self.has_duplicate_lesson? (user_id, lesson_id)
    self.where(user_id: user_id, lesson_id: lesson_id).where("expired_time > ?", Time.now.utc).any?
  end
  
  def self.get_lesson_transaction_records (user_id, params)
  
	scope = joins(:lesson)
    scope = scope.where(lessons: { lesson_type: params[:lesson_type] })     if params[:lesson_type].present?
    scope = scope.where("expired_time > ?", Time.now.utc)                   if params[:available].to_s.downcase == 'true'
	scope = scope.where(user_id: user_id)
    scope
	
  end
end
