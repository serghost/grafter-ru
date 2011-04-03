class UniversitiesController < ApplicationController
  before_filter :authorize_admin!, :only => [:edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :reviews, :index]
  before_filter :find_university_id, :only => [:show, :reviews, :destroy, :edit, :update]
  before_filter :tabs, :only => [:show, :reviews]

  respond_to :html, :json

  def show
    @lessons = @university.lessons.page params[:page]

    @tabs.active! :prices
  end

  def reviews
    @reviews = @university.reviews.where("kind LIKE ?", params[:kind].presence || '%').page params[:page]

    @tabs.active! :reviews
    render "show"
  end

  def index
    @hide_search_bar = true

    respond_to do |format|
     format.html {
       # FIXME: Move to model as scope!
       @universities = University.where("short LIKE ? OR title LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").includes(:city).order(:city_id).page params[:page]
     }
     format.json {render :json => University.where("short LIKE ?", "%#{params[:term]}%").map {|university| {:id => university.id, :value => university.short}}}
    end
  end

  def new
    @university = University.new
  end

  def create
    @university = University.new params[:university]

    if @university.save
      redirect_to university_path(@university), :notice => "University has been created."
    else
      flash[:alert] = "University has not been created."
      render :action => "new"
    end
  end

  def edit
  end

  def destroy
    if @university.destroy
      redirect_to universities_path, notice: "University has been deleted."
    end
  end

  def update
    if @university.update_attributes(params[:university])
      redirect_to @university, :notice => "University has been updated."
    else
      flash[:alert] = "University has not been updated."
      render :action => :edit
    end
  end

private
  def tabs
    @tabs = Tabs.new({prices: university_path(@university), reviews: university_reviews_path(@university)})
  end
end
