class Price < ActiveRecord::Base
  attr_reader :personal

  belongs_to :university
  belongs_to :teacher

  paginates_per 20

  def personal=(full_name)
    
  end
end
