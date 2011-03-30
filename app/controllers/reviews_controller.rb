class ReviewsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_university, :except => :index
  before_filter :find_review, :only => [:edit, :destroy, :update]

  def new
    @review = @university.reviews.new
  end

  def create
    @review = @university.reviews.new params[:review]

    if @review.save
      redirect_to university_reviews_path, :notice => "Review has been created."
    else
      flash[:alert] = "Review has not been created."
      render "new"
    end
  end

  def edit
  end

  def update
    if @review.update_attributes(params[:review])
      redirect_to university_reviews_path, :notice => "Review has been updated."
    else
      flash[:alert] = "Review has not been updated."
      render :action => "new"
    end
  end

  def destroy
    if @review.destroy
      redirect_to university_reviews_path, :notice => "Review has been deleted."
    end
  end
  private

  def find_university
    @university = University.find params[:university_id]
  end

  def find_review
    @review = @university.reviews.find params[:id]
  end
end
