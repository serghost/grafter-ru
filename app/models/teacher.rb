class Teacher < ActiveRecord::Base
  belongs_to :university

  has_many :prices, :dependent => :destroy

  validates :personal, :presence => true,
    :format => /^([^0-9]+)\ ([^0-9]+)\ ([^0-9]+)$/
end
