class ReviewsController < ApplicationController

def index	
end

def show
  
end

def create
    @review = Review.new(review_params)
    resp ||= []
    if @review.save
      resp << {'status' => 'success'}
      respond_to do |format|
        format.json { render json: resp }
      end
    else
      resp << {'status' => 'failed'}
      respond_to do |format|
        format.json { render json: resp }
      end
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
    
    @review = Review.new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.destroy! && @review.user == current_user
        format.html { redirect_to book_path(@review.book_id), flash: { success: "Review deleted."} }
      else
        format.html { redirect_to book_path(@review.book_id), flash: { error: "Sorry, the review wasn't deleted!"} }
      end

      format.js
    end
  end
  
  private
  
  def review_params
    params.require(:review).permit( :body, :user_id, :book_id)
  end
  

end
