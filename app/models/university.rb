class University < ActiveRecord::Base
  belongs_to :city

  has_many :prices, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_many :teachers

  validates :short, :presence => true, :length => {:in => 2..10}
  validates :title, :uniqueness => true, :presence => true, :length => {:minimum => 7}
  validates :city_id, :presence => true

  has_attached_file :logo, :styles => {:thumb => '32x32', :original => '64x64'},
    :url => "/images/:class/:attachment/:id/:style.:extension",
    :default_url => "/images/:class/missing.png",
    :convert_options => { :all => '-background white -flatten +matte'}

  paginates_per 25
end
