class RecommendsController < ApplicationController
  
  def show
  end
  
  def create
    @recommend = Recommend.new(rec_params)
    
    if @recommend.save
      if params[:recommend][:item_type] == "book"
        redirect_to(book_path(params[:recommend][:book_id]), :notice => "You just recommended this book.")
      else
        redirect_to(author_path(params[:recommend][:author_id]), :notice => "You just recommended this author.")
      end
    else
      redirect_to root_path
    end
  end


  def modrec
    @recommend = Recommend.new(rec_params)
    resp ||= []
    if @recommend.save
      if params[:recommend][:item_type] == "book"
        resp << {'status' => 'success'}
        respond_to do |format|
          format.json { render json: resp }
        end
      else
        redirect_to author_book_path(:id => params[:recommend][:item_id])
      end
    else
      
    end
  end
  
  def destroy
  end
  
  def update
  end
  
  def top_book
    @client = Goodreads.new(Goodreads.configuration)
    @top_books = Recommend.where(:item_type => "book").count(:group => :item_id, :order => "count_all DESC")
  end
  
  def top_author
    @client = Goodreads.new(Goodreads.configuration)
    @top_author = Recommend.where(:item_type => "author").count(:group => :item_id, :order => "count_all DESC")
  end
  
  private
  
  def rec_params
    params.require(:recommend).permit(:user_id, :book_id, :author_id, :item_type)
  end
end