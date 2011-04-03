class LessonsController < ApplicationController
  before_filter :authorize_admin!, :only => [:update, :edit, :destroy]
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
    @tabs = Tabs.new({prices: university_path(@university), reviews: university_reviews_path(@university)})
    @tabs.active! :prices

    @prices = @lesson.prices.page params[:page]
  end

  def destroy
    @lesson.destroy

    redirect_to @university, :notice => "Lesson has been deleted."
  end

  def edit
  end

  def update
    if @lesson.update_attributes(params[:lesson])
      redirect_to @university, :notice => "Lesson has been updated."
    else
      flash[:alert] = "Lesson has not been updated."
      render :action => :edit
    end
  end
end
