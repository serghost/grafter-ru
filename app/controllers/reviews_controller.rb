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
      redirect_to university_reviews_path, :notice => t(:rewcr_text)
    else
      flash[:alert] = t(:rewnotcr_text)
      render "new"
    end
  end

  def edit
  end

  def update
    if can?(:edit, @review)
      if @review.update_attributes(params[:review])
        redirect_to university_reviews_path(@university), :notice => t(:rewup_text)
      else
        flash[:alert] = t(:rewnotup_text)
        render :action => :edit
      end
    else
      redirect_to university_reviews_path(@university), :notice => t(:denied_text)
    end
  end

  def destroy
    if can?(:edit, @review)
      if @review.destroy
        redirect_to university_reviews_path(@university), :notice => t(:rewdel_text)
      end
    else
      redirect_to university_reviews_path(@university), :notice => t(:denied_text)
    end
  end
end
