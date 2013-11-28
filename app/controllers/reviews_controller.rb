class ReviewsController < ApplicationController

def index	
end

def show
  
end

def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to current_user
    else
      redirect_to root_path
    end
 end

 def new
    @review = Review.new(review_params)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @review }
    end
  end
  
  def gonew
    client = Goodreads.new(Goodreads.configuration)
    @book = client.book(params[:id])
  end

  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit( :body, :user_id, :book_id)
  end
  

end
