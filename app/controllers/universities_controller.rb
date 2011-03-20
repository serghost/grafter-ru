class UniversitiesController < ApplicationController
  before_filter :university_id, :except => [:search, :index, :new, :create]
  before_filter :tabs, :only => [:show, :reviews]

  respond_to :html, :json, :xml

  def search

  end

  def show
    @tabs.active! :prices
  end

  def reviews
    @tabs.active! :reviews

    render "show"
  end

  def index
    @universities = University.all
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
