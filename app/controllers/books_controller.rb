class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :start_future_read, :destroy]
  before_action :set_api, only: [:goodread_search, :add_goodreads]
  
	def index
    @result = Book.search(params[:search])
  end

  def show  
    @recommends = @book.recommends
    if signed_in?
      @list_read = Archive.new
      @myrecommend = @book.recommends.where(:user_id => current_user.id)
    end
  end

  def new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to current_user
    else
      redirect_to root_path
    end
  end
  
  def book_readit
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to current_user
    else
      redirect_to root_path
    end
  end

  def update
    if @book.update_attribute(:status, "1")
      redirect_to finished_path(:id => @book.olidb)
    else
      redirect_to root_path
    end
  end

  def future_list
    @future = current_user.books.build(book_params)
    @future.activity key: 'book.future_list'
    
    if @future.save
      redirect_to current_user
    else
      redirect_to root_path
    end
  end
  
  def start_future_read
    @book.activity key: 'book.future_read'
    if @book.update_attribute(:status, "0")
      redirect_to current_user
    else
      redirect_to root_path
    end
  end
  
  def past_list
    @past = current_user.books.build(book_params)
    @past.activity key: 'book.past_list'
    
    if @past.save
      redirect_to current_user
    else
      redirect_to root_path
    end
  end

  def reorder
    params[:data].each do |key, array|
      @book = Book.find_by(:olidb => array[:book_id])
      @book.update_attribute(:order, array[:order])
    end

    respond_to do |format|
      format.json { render json: 'OK' }
    end
  end

  def finishedmodal
    @thebook = @client.book(params[:id]) unless @client.book(params[:id]).blank?
    @slug = @thebook.title.parameterize
  
    if user_signed_in?
      @newbook = Book.new
      @mybook = Book.where(:user_id => current_user.id).where(:olidb => params[:id])
      @myrecommend = Recommend.where(:user_id => current_user.id).where(:item_id => params[:id])
      @user = current_user
    end
    
    @review = Review.where(:book_id => params[:id])
    @new_recommend = Recommend.new

    # Select random books for suggestions
    also = Book.select(:user_id).uniq.where(:olidb => params[:id])
    @also_read = Book.where(user_id: also).where(:status => "1").limit(4).order("RANDOM()")
  end

  def destroy
    @book.destroy
    redirect_to root_path
  end
  
  def goodread_search
    @gr_result = @client.search_books(params[:search])
  end
  
  def add_goodreads
    @goodread = @client.book(params[:id])
    @book = Book.create(:title => @goodread.title, :isbn => @goodread.isbn, :description => @goodread.description)
    
    if @book.save
      @book_id = @book.id
      @connect = Archive.create(:user_id => current_user.id, :book_id => @book_id, :status => params[:status])
      if @connect.save
        redirect_to(book_path(@book_id), :notice => "You just added this book to your collection")
      else
        redirect_to(root_path, :notice => "Failed to add a connection between you and the book")
      end
    else
      redirect_to(root_path, :notice => "Could not add the book from the GR API")
    end
  end
  
  private
  
  def set_book
    @book = Book.find(params[:id])
  end
  
  def set_author
    @author = Author.find(params[:id])
  end
  
  def set_api
    @client = Goodreads.new(Goodreads.configuration)
  end
  
  def book_params
    params.require(:book).permit(:title, :status, :isbn, :description)
  end
end
