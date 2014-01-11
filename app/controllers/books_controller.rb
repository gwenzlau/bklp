class BooksController < ApplicationController
  before_action :set_book, only: [:update, :start_future_read, :destroy]
  before_action :set_api, only: [:show, :author, :finishedmodal]
  
	def index
    @books = Book.all
  end

  def show  
    # Get the metadata from Goodreads
    @thebook = @client.book(params[:id]) unless @client.book(params[:id]).blank?
    @slug = @thebook.title.parameterize
  
    if user_signed_in?
      @newbook = current_user.books.build
      @mybook = Book.where(:user_id => current_user.id).where(:olidb => params[:id])
      @myrecommend = Recommend.where(:user_id => current_user.id).where(:item_id => params[:id])
      @myreview = Review.where(:user_id => current_user.id).where(:book_id => params[:id])
      @new_recommend = Recommend.new
    end
    
    #Users currently reading this book
    @users_reading = Book.where(:olidb => params[:id]).where(:status => "0")
    @review = Review.where(:book_id => params[:id])
    @total_recommend = Recommend.where(:item_id => params[:id]).count
    @recommends = Recommend.where(:item_id => params[:id])
    
    # Selecting random books for suggestions
    also = Book.select(:user_id).uniq.where(:olidb => params[:id])
    @also_read = Book.where(user_id: also).where(:status => "1").limit(4).order("RANDOM()")
  end
  
  def author
    @theauthor = @client.author(params[:id])
    @authorbooks = @client.search_books(@theauthor.name)
    
    @myrecommend = Recommend.where(:user_id => current_user.id).where(:item_id => params[:id])
    @total_recommends = Recommend.where(:item_id => params[:id]).where(:item_type => "author").count
    @new_recommend = Recommend.new

    @users_fan = Recommend.where(:item_id => params[:id]).where(:item_type => "author").limit(9).order("RANDOM()")
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
  
  private
  
  def set_book
    @book = Book.find(params[:id])
  end
  
  def set_api
    @client = Goodreads.new(Goodreads.configuration)
  end
  
  def book_params
    params.require(:book).permit(:title, :author, :olida, :olidb, :user_id, :status, :rec, :recommend, :order, :isbn, :slug)
  end
end
