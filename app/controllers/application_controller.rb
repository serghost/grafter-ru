class ApplicationController < ActionController::Base
  protect_from_forgery

  def university_id
    @university ||= University.find params[:university_id].presence || params[:id]
  end
end
