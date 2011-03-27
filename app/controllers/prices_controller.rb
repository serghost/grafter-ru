class PricesController < ApplicationController
  before_filter :find_university, :except => :index
  before_filter :find_price, :only => [:edit, :update, :show]
  before_filter :find_revision, :only => [:revision, :revision_remove]

  def new
    @price = @university.prices.new
  end

  def edit
  end

  def show
  end

  def update
    if @price.update_attributes(params[:price])
      redirect_to [@university, @price], :notice => "Price has been updated."
    else
      flash[:alert] = "Price has not been updated."
      render :action => "new"
    end
  end

  def create
    @price = @university.prices.new params[:price]

    if @price.save
      redirect_to [@university, @price], :notice => "Price has been created."
    else
      flash[:alert] = "Price has not been created."
      render :action => "new"
    end
  end

  def revision
    @price = @revision.reify

    if @price.save
      @revision.destroy
      flash[:notice] = "Price has been updated."
    else
      flash[:alert] = "Price has not been updated."
    end

    redirect_to edit_university_price_path(@university, @price)
  end

  def revision_remove
    @price = Price.find params[:price_id]
    @revision.destroy

    redirect_to edit_university_price_path(@university, @price), :notice => "Revision has been deleted."
  end

  private

  def find_university
    @university = University.find params[:university_id]
  end

  def find_price
    @price = Price.find params[:id]
  end

  def find_revision
    @revision = Version.find params[:version]
  end
end
