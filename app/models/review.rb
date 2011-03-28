class Review < ActiveRecord::Base
  belongs_to :university
  belongs_to :user

  validates :text, :presence => true, :length => {:in => 10..1000}
  validates :kind, :presence => true

  REVIEW_KINDS = {"Good" => 1, "Bad" => -1, "Neutral" => 0}
end
