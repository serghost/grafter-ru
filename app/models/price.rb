class Price < ActiveRecord::Base
  before_save :find_teacher
  before_save :find_lesson

  belongs_to :lesson
  belongs_to :teacher
  belongs_to :university

  validates_numericality_of :score_5,     :less_than => 100_000_000, :greater_than => 1
  validates_numericality_of :score_4,     :less_than => 100_000_000, :greater_than => 1
  validates_numericality_of :score_3,     :less_than => 100_000_000, :greater_than => 1
  validates_numericality_of :test,        :less_than => 100_000_000, :greater_than => 1
  validates_numericality_of :course_work, :less_than => 100_000_000, :greater_than => 1
  validates_numericality_of :attestation, :less_than => 100_000_000, :greater_than => 1

  validates :lesson, :presence => true, :format => /^([\w\s]+)$/
  validates :personal, :presence => true,
    :format => /^([^\W0-9]+)\ ([^\W0-9]+)\ ([^\W0-9]+)$/

  attr_accessor :personal, :lesson
  paginates_per 20

  private

  def find_teacher
    university = University.find(self.university_id)
    full_name = @personal.split(" ").map(&:capitalize).join(" ")

    if university.present?
      teacher = university.teachers.where("personal ILIKE ?", full_name).limit(1) # FIXME

      if teacher.present?
        self.teacher_id = teacher[0].id # FIXME
      else
        self.teacher_id = university.teachers.create!(:personal => full_name).id
      end
    else
      raise "University can't be blank"
    end
  end

  def find_lesson
    university = University.find(self.university_id)
    lesson_title = @lesson.split(" ").map(&:capitalize).join(" ")

    if university.present?
      lesson = university.lessons.where("title ILIKE ?", lesson_title).limit(1) # FIXME

      if lesson.present?
        self.lesson_id = lesson[0].id # FIXME
      else
        self.lesson_id = university.lessons.create!(:title => lesson_title).id
      end
    else
      raise "Lesson can't be blank"
    end
  end
end
