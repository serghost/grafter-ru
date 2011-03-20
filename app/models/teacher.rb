class Teacher < ActiveRecord::Base
  belongs_to :university

  has_many :prices
end
