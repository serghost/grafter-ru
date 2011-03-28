class ReviewsController < ApplicationController
  before_filter :find_university, :except => :index

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

  private

  def find_university
    @university = University.find params[:university_id]
  end
end
