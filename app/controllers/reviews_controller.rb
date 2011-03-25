class ReviewsController < ApplicationController
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
end
