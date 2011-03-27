class Lesson < ActiveRecord::Base
  belongs_to :university

  has_many :prices

  validates :title, :presence => true
end
