class Lesson < ApplicationRecord

  def self.find_lesson (subject)
	self.where(subject: subject)
  end

  def self.has_duplicate_lesson? (subject)
	self.find_lesson(subject).any?
  end
  
  def has_duplicate_lesson_without_self? (subject)
	Lesson.find_lesson(subject).where.not(id: id).any?
  end
end
