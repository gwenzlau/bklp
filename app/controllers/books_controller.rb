class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :start_future_read, :destroy]
  before_action :set_api, only: [:goodread_search, :add_goodreads]
  
	def index
    @result = Book.search(params[:search])
  end

  def show  
    @recommends = @book.recommends
    @reviews = @book.reviews
    if signed_in?
      @list_read = Archive.new
      @recommend = Recommend.new
      @review = Review.new
      @myrecommend = @book.recommends.where(:user_id => current_user.id)
      @myreview = @book.reviews.where(:user_id => current_user.id)
      @status = current_user.archives.where(:book_id => params[:id])
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
  end
  
  def start_future_read
    @book.activity key: 'book.future_read'
    if @book.update_attribute(:status, "0")
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
      
      if @goodread.authors.author[0].blank?
        @author_gr = @client.author(@goodread.authors.author.id)
        @author = Author.create(:name => @goodread.authors.author.name, :description => @author_gr.about)
        Work.create(:author_id => @author.id, :book_id => @book_id) if @author.save
      else
        @goodread.authors.author.each do |a|
          @author_gr = @client.author(a.id)
          @author = Author.create(:name => a.name, :description => @author_gr.about)
          Work.create(:author_id => @author.id, :book_id => @book_id) if @author.save
        end
      end
      
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
