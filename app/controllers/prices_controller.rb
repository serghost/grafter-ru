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
      redirect_to [@university, @price], :notice => t(:prup_text)
    else
      flash[:alert] = t(:prnotup_text)
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

        redirect_to [@university, duplicate.lesson], :notice => t(:prup_text) if duplicate.save
      else
        @price.save

        redirect_to [@university, @price.lesson], :notice => t(:prnotup_text) if @price.save
      end

    else
      flash[:alert] = t(:prnotcr_text)
      render :action => "new"
    end
  end

  def revision
    @price = @version.reify

    if @price.save
      @version.destroy
      flash[:notice] = t(:prup_text)
    else
      flash[:alert] = t(:prnotup_text)
    end

    redirect_to edit_university_price_path(@university, @price)
  end

  def revision_remove
    @price = Price.find params[:price_id]
    @version.destroy

    redirect_to edit_university_price_path(@university, @price), :notice => t(:revdel_text)
  end

  def delete_revisions
    @price.versions.each do |version|
      version.destroy
    end

    redirect_to edit_university_price_path(@university, @price), :notice => t(:allrevdel_text)
  end

  def destroy # FIXME: Move this code into model with callback! Thin controller, fat model!
    @price.versions.each do |revision|
      revision.destroy
    end

    Price.delete_with_lesson(@price) # FIXME: Add disable for storing destroy action
    redirect_to @university, notice: t(:prdel_text)
  end
end
