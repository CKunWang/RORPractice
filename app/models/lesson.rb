class Lesson < ApplicationRecord
  
  has_many :lesson_transactions
  has_many :users, :through => :lesson_transactions
  
  validates_presence_of :subject, :currency, :price, :lesson_type, :url, :description, :expired_days
  

  def self.find_lesson (subject)
	self.where(subject: subject)
  end

  def self.has_duplicate_lesson? (subject)
	self.find_lesson(subject).any?
  end
  
  def self.user_available_lessons
	self.where(is_available: true)
  end
  
  def self.find_user_specified_lesson (lesson_id)
	self.user_available_lessons.find_by(id: lesson_id)
  end
  
  def has_duplicate_lesson_without_self? (subject)
	self.class.find_lesson(subject).where.not(id: id).any?
  end
end
