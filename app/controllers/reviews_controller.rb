class ReviewsController < ApplicationController
  before_filter :find_university, :except => :index

  def new
    @review = @university.reviews.new
  end

  def create
    @review = @university.reviews.new params[:review]
    # FIXME
    @review.user_id = current_user.id

    if @review.save
      redirect_to university_reviews_path, :notice => "Successfully review created."
    else
      render "new"
    end
  end

  private

  def find_university
    @university = University.find params[:university_id]
  end
end
