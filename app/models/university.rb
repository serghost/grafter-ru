class University < ActiveRecord::Base
  belongs_to :city

  has_attached_file :logo, :styles => {:thumb => '32x32', :original => '64x64'},
    :url => "/images/:class/:attachment/:id/:style_:basename.:extension",
    :default_url => "/images/:class/missing.png"

  validates :short, :presence => true, :length => {:in => 2..10}
  validates :title, :uniqueness => true, :presence => true, :length => {:minimum => 7}
  validates :city_id, :presence => true
end
