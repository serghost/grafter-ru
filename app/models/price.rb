class Price < ActiveRecord::Base
  belongs_to :university
  belongs_to :teacher
end
