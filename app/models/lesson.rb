class Lesson < ActiveRecord::Base
  belongs_to :university

  has_many :prices, :dependent => :destroy

  validates :title, :presence => true
end
