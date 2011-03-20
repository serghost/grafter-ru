class Price < ActiveRecord::Base
  attr_reader :personal

  belongs_to :university
  belongs_to :teacher
end
