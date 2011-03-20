class PricesController < ApplicationController
  before_filter :university_id

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
      redirect_to @university, :notice => "Successfully price created."
    else
      render "new"
    end
  end
end
