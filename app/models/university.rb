class University < ActiveRecord::Base
  belongs_to :city

  validates :short, :presence => true, :length => {:in => 2..10}
  validates :title, :uniqueness => true, :presence => true, :length => {:minimum => 7}
  validates :city_id, :presence => true

  has_attached_file :logo, :styles => {:thumb => '32x32', :original => '64x64'},
    :url => "/images/:class/:attachment/:id/:style.:extension",
    :default_url => "/images/:class/missing.png"
end
