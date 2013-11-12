class ReviewsController < ApplicationController
def index	
end

def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to current_user
    else
      redirect_to root_path
    end
 end

  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit( :body)
  end
  

end
