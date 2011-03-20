class ApplicationController < ActionController::Base
  protect_from_forgery

  def university_id
    @university ||= University.find params[:id].presence || params[:university_id]
  end
end
