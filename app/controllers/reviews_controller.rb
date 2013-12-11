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

  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit( :body, :user_id, :book_id)
  end
  

end
