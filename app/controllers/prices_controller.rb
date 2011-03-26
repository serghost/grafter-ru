class PricesController < ApplicationController
  before_filter :find_university, :except => :index

  def index

  end

  def new
    @price = @university.prices.new
  end

  def edit
    @price = Price.find params[:id]
  end

  def show

  end

  def create
    @price = @university.prices.new params[:price]
    # FIXME
    @price.user_id = 1

    if @price.save
      redirect_to @university, :notice => "Price has been created."
    else
      flash[:alert] = "Price has not been created."
      render :action => "new"
    end
  end

  private

  def find_university
    @university = University.find params[:university_id]
  end
end
