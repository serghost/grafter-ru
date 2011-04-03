class LessonsController < ApplicationController
  before_filter :find_university_id
  before_filter :find_lesson_id, :except => :index
  respond_to :html, :json

  def index
    @lessons = Lesson.where("title LIKE ? and university_id LIKE ?", "%#{params[:term]}%", @university)

    respond_to do |format|
     format.html
     format.json {render :json => @lessons.map {|lesson| {:id => lesson.id, :value => lesson.title}}}
    end
  end

  def show
    @prices = @lesson.prices.page params[:page]
  end
end
