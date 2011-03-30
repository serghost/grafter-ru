class University < ActiveRecord::Base
  belongs_to :city

  has_many :lessons, :dependent => :destroy
  has_many :prices, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_many :teachers

  validates :short, :presence => true, :length => {:in => 2..10}
  validates :city_id, :presence => true
  validates :title, :presence => true, :length => {:minimum => 7}

  validate :check_for_already_exists

  has_attached_file :logo, :styles => {:thumb => '32x32', :original => '64x64'},
    :url => "/images/:class/:attachment/:id/:style.:extension",
    :default_url => "/images/:class/missing.png",
    :convert_options => { :all => '-background white -flatten +matte'}

  has_paper_trail

  paginates_per 25

  def check_for_already_exists
    @exists_university = University.where("title LIKE ?", self.title).limit(1)[0]

    if @exists_university.present?
      errors.add(:title, "this university is already exists")
    end
  end
end
