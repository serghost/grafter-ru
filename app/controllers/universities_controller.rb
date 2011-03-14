class UniversitiesController < ApplicationController
  before_filter :university_id, :except => [:search, :index, :new, :create]

  respond_to :html, :json, :xml

  def search

  end

  def show

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

private
  def university_id
    @university = University.find params[:id]
  end
end
