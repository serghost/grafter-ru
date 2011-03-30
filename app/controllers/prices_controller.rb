class PricesController < ApplicationController
  before_filter :authorize_admin!, :only => [:destroy, :revision, :revision_remove]
  before_filter :authenticate_user!, :except => [:show, :destroy, :revision, :revision_remove]
  before_filter :find_university, :except => :index
  before_filter :find_price, :only => [:edit, :update, :show, :destroy]
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

    if @price.valid?
      duplicate = @price.find_duplicate

      if duplicate.present?
        [:score_5, :score_4, :score_3, :test, :attestation, :course_work].each do |key|
          # raise "#{params[:price][key]}"
          duplicate[key] = params[:price][key]
        end

        redirect_to [@university, duplicate], :notice => "Price has been updated." if duplicate.save
      else
        redirect_to [@university, @price], :notice => "Price has been created." if @price.save
      end

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

  def destroy # FIXME: Move this code into model with callback! Thin controller, fat model!
    @price.versions.each do |revision|
      revision.destroy
    end

    @price.destroy # FIXME: Add disable for storing destroy action
    redirect_to @university, notice: "Price has been deleted."
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
