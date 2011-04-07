class Review < ActiveRecord::Base
  attr_protected :user_id

  belongs_to :university
  belongs_to :user

  validates :text, :presence => true, :length => {:in => 10..1000}
  validates :kind, :presence => true

  REVIEW_KINDS = {I18n.t(:g_text) => 1, I18n.t(:b_text) => -1, I18n.t(:n_text) => 0}
  REVIEW_CLASS = {1 => I18n.t(:g_text), -1 => I18n.t(:b_text), 0 => I18n.t(:n_text)}
end
