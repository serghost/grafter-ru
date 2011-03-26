class UniversitiesController < ApplicationController
  before_filter :get_university_id, :only => [:show, :reviews, :destroy, :edit, :update]
  before_filter :tabs, :only => [:show, :reviews]

  respond_to :html, :json, :xml

  autocomplete :university, :short

  def show
    @prices = @university.prices.where("lesson ILIKE ?", "%#{params[:lesson]}%").page params[:page]

    @tabs.active! :prices
  end

  def reviews
    @reviews = @university.reviews

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

  def destroy
    if @university.destroy
      redirect_to universities_path, notice: "University has been deleted."
    else
      redirect_to @university
    end
  end

  def update
    if @university.update_attributes(params[:university])
      redirect_to @university, :notice => "University has been updated."
    else
      flash[:alert] = "University has not been updated."
      render :action => "new"
    end
  end

private
  def tabs
    @tabs = Tabs.new({prices: university_path(@university), reviews: university_reviews_path(@university), feed: "#"})
  end

  def get_university_id
    @university = University.find params[:id]
  end
end
