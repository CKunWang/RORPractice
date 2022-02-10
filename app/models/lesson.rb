class Lesson < ApplicationRecord

  def has_duplicate_lesson?
	(id.blank?) ? Lesson.where(subject: subject).any? : Lesson.where(subject: subject).where.not(id: id).any?
  end
end
