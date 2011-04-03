class ReviewsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_university_id, :except => :index
  before_filter :find_review_id, :only => [:edit, :destroy, :update]

  def new
    @review = @university.reviews.new
  end

  def create
    @review = @university.reviews.new params[:review]
    @review.user_id = current_user.id

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
    if can?(:edit, @review)
      if @review.update_attributes(params[:review])
        redirect_to university_reviews_path(@university), :notice => "Review has been updated."
      else
        flash[:alert] = "Review has not been updated."
        render :action => :edit
      end
    else
      redirect_to university_reviews_path(@university), :notice => "Access denied."
    end
  end

  def destroy
    if can?(:edit, @review)
      if @review.destroy
        redirect_to university_reviews_path(@university), :notice => "Review has been deleted."
      end
    else
      redirect_to university_reviews_path(@university), :notice => "Access denied."
    end
  end
end
