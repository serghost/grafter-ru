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

  has_paper_trail :ignore => [:lesson_id, :teacher_id, :university_id]
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

  def find_duplicate
    if self.new_record?
      Price.where("university_id = ? AND lesson_id = ? AND teacher_id = ?", find_university.id, find_lesson, find_teacher).limit(1)[0].presence
    else
      false
    end
  end

  def compare_with(revision)
    compare_hash = {}

    [:score_5, :score_4, :score_3, :test, :attestation, :course_work].each do |key|
      if self[key] != revision.reify[key]
        compare_hash[key] = revision.reify[key]
      end
    end

    compare_hash
  end

  private

  def find_university
    @university = University.find(self.university_id)
  end

  def find_teacher
    if @university.present?
      teacher = @university.teachers.where("personal LIKE ?", self.personal).limit(1) # FIXME

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
      lesson = @university.lessons.where("title LIKE ?", self.lesson).limit(1) # FIXME

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
