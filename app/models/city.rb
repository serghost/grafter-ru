class City < ActiveRecord::Base
  belongs_to :department

  has_many :universities
end
