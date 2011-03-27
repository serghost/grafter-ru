class Price < ActiveRecord::Base
  before_save :find_university, :find_teacher, :find_lesson

  belongs_to :lesson
  belongs_to :teacher
  belongs_to :university

  validates_numericality_of :score_5,     :less_than => 100_000_000, :greater_than => 1
  validates_numericality_of :score_4,     :less_than => 100_000_000, :greater_than => 1
  validates_numericality_of :score_3,     :less_than => 100_000_000, :greater_than => 1
  validates_numericality_of :test,        :less_than => 100_000_000, :greater_than => 1
  validates_numericality_of :course_work, :less_than => 100_000_000, :greater_than => 1
  validates_numericality_of :attestation, :less_than => 100_000_000, :greater_than => 1

  validates :lesson, :presence => true
  validates :personal, :presence => true,
    :format => /^([^0-9]+)\ ([^0-9]+)\ ([^0-9]+)$/

  has_paper_trail
  paginates_per 20

  def personal=(full_name)
    @personal_title = full_name.split(" ").map(&:capitalize).join(" ")
  end

  def personal
    return @personal_title if @personal_title.present?

    if self.teacher_id.present?
      Teacher.find(self.teacher_id).personal
    end
  end

  def lesson=(title)
    @lesson_title = title.split(" ").map(&:capitalize).join(" ")
  end

  def lesson
    return @lesson_title if @lesson_title.present?

    if self.lesson_id.present?
      Lesson.find(self.lesson_id).title
    end
  end

  private

  def find_university
    @university = University.find(self.university_id)
  end

  def find_teacher
    if @university.present?
      teacher = @university.teachers.where("personal ILIKE ?", self.personal).limit(1) # FIXME

      if teacher.present?
        self.teacher_id = teacher[0].id # FIXME
      else
        self.teacher_id = @university.teachers.create!(:personal => self.personal).id
      end
    else
      raise "University can't be blank"
    end
  end

  def find_lesson
    if @university.present?
      lesson = @university.lessons.where("title ILIKE ?", self.lesson).limit(1) # FIXME

      if lesson.present?
        self.lesson_id = lesson[0].id # FIXME
      else
        self.lesson_id = @university.lessons.create!(:title => self.lesson).id
      end
    else
      raise "Lesson can't be blank"
    end
  end
end
