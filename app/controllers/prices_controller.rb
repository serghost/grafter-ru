class PricesController < ApplicationController
  before_filter :authorize_admin!, :only => [:destroy, :revision, :revision_remove, :delete_revisions]
  before_filter :authenticate_user!, :except => [:show, :destroy, :revision, :revision_remove, :delete_revisions]
  before_filter :find_university_id, :except => :index
  before_filter :find_price_id, :only => [:edit, :update, :show, :destroy, :delete_revisions]
  before_filter :find_version, :only => [:revision, :revision_remove]

  def new
    @price = @university.prices.new
  end

  def edit
    if can?(:review, @price) and @price.versions.present?
      @revisions = @price.versions
    end
  end

  def show
  end

  def update
    if @price.update_attributes(params[:price])
      redirect_to [@university, @price], :notice => "Price has been updated."
    else
      flash[:alert] = "Price has not been updated."
      render :action => :edit
    end
  end

  def create
    @price = @university.prices.new params[:price]

    if @price.valid?
      duplicate = @price.find_duplicate

      if duplicate.present?
        [:score_5, :score_4, :score_3, :test, :attestation, :course_work].each do |key|
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
    @price = @version.reify

    if @price.save
      @version.destroy
      flash[:notice] = "Price has been updated."
    else
      flash[:alert] = "Price has not been updated."
    end

    redirect_to edit_university_price_path(@university, @price)
  end

  def revision_remove
    @price = Price.find params[:price_id]
    @version.destroy

    redirect_to edit_university_price_path(@university, @price), :notice => "Revision has been deleted."
  end

  def delete_revisions
    @price.versions.each do |version|
      version.destroy
    end

    redirect_to edit_university_price_path(@university, @price), :notice => "All revisions has been deleted."
  end

  def destroy # FIXME: Move this code into model with callback! Thin controller, fat model!
    @price.versions.each do |revision|
      revision.destroy
    end

    @price.destroy # FIXME: Add disable for storing destroy action
    redirect_to @university, notice: "Price has been deleted."
  end
end
