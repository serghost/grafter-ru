class UniversitiesController < ApplicationController
  before_filter :university_id, :except => [:search, :index, :new, :create]
  before_filter :tabs, :only => [:show, :reviews]

  respond_to :html, :json, :xml

  def show
    @prices = @university.prices.where("lesson ILIKE ?", "%#{params[:lesson]}%").page params[:page]

    @tabs.active! :prices
  end

  def reviews
    @tabs.active! :reviews

    render "show"
  end

  def index
    # FIXME: Move to model as scope!
    @universities = University.where("short ILIKE ? OR title ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").order(:city_id).page params[:page]
    @hide_search_bar = true

    respond_with @universities
  end

  def new
    @university = University.new
  end

  def create
    @university = University.new params[:university]

    if @university.save
      redirect_to university_path(@university), :notice => "Successfully created."
    else
      render "new"
    end
  end

  def edit
    
  end

  def destroy # FIXME: Dirty dirty code
    if @university.destroy
      redirect_to universities_path, notice: "Successfuly deleted."
    else
      redirect_to @university
    end
  end

  def update
    @university.update_attributes params[:university]
    redirect_to @university
  end

private
  def tabs
    @tabs = Tabs.new({prices: university_path(university_id), reviews: university_reviews_path(university_id), feed: "#"})
  end
end
