class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.create(review_params)
    if @review.save
      flash[:notice] = "Review submitted successfully"
      redirect_to restaurant_path(@restaurant)
    else
      render "new"
    end
  end

  private

  def review_params
    review_params = params.require(:review).permit(:body, :rating)
    restaurant_id = params.permit(:restaurant_id)[:restaurant_id]
    review_params[:restaurant_id] = restaurant_id
    review_params
  end
end
