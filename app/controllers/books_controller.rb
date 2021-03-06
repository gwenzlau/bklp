class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :start_future_read, :destroy]
  before_action :set_api, only: [:goodread_search, :add_goodreads]
  
	def index
    if params.has_key?(:q)
      books ||= []
      @results = Book.search(params[:q])
      for book in @results
        books << { 'book' => book.title, 'book_id' => book.id, 'isbn' => book.isbn, 'shortbook' => book.title.parameterize }
      end 
      render json: books
    else  
      @result = Book.search(params[:search])
    end
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
      @user = current_user
    end
    
    also = Archive.select(:user_id).uniq.where(:book_id => params[:id])
    @suggestions = Recommend.where(:item_type => "book").where(user_id: also).limit(4).order("RANDOM()")
  end

  def new
  end

  def create
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
    @recommends = @book.recommends
    @reviews = @book.reviews
    
    if signed_in?
      @list_read = Archive.new
      @recommend = Recommend.new
      @review = Review.new
      @myrecommend = @book.recommends.where(:user_id => current_user.id)
      @myreview = @book.reviews.where(:user_id => current_user.id)
      @status = current_user.archives.where(:book_id => params[:id])
      @user = current_user
    end
    
    also = Archive.select(:user_id).uniq.where(:book_id => params[:id])
    @suggestions = Recommend.where(user_id: also).limit(4).order("RANDOM()")
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
      
      if params[:status].blank?
        # Do nothing since the user is not adding to archive
      else
        @connect = Archive.create(:user_id => current_user.id, :book_id => @book_id, :status => params[:status])
      end
      
      if @goodread.authors.author[0].blank?
        if Author.where(:name => @goodread.authors.author.name).blank?
          @author_gr = @client.author(@goodread.authors.author.id)
          @author = Author.create(:name => @goodread.authors.author.name, :description => @author_gr.about, :image_url => @author_gr.image_url)
          Work.create(:author_id => @author.id, :book_id => @book_id) if @author.save
        else
          @local_author = Author.where(:name => @goodread.authors.author.name)
          Work.create(:author_id => @local_author[0].id, :book_id => @book_id)
        end
      else
        @goodread.authors.author.each do |a|
          if Author.where(:name => a.name).blank?
            @author_gr = @client.author(a.id)
            @author = Author.create(:name => a.name, :description => @author_gr.about, :image_url => @author_gr.image_url)
            Work.create(:author_id => @author.id, :book_id => @book_id) if @author.save
          else
            @local_author = Author.where(:name => a.name)
            Work.create(:author_id => @local_author[0].id, :book_id => @book_id)
          end
        end
      end
      
      if params[:status].blank?
        redirect_to book_path(@book_id)
      else
        if @connect.save
          redirect_to(book_path(@book_id), :notice => "You just added this book to your collection")
        else
          redirect_to(root_path, :notice => "Failed to add a connection between you and the book")
        end
      end
    else
      # If book exists in the DB
      @book = Book.where(:title => @goodread.title)
      
      if params[:status].blank?
        redirect_to book_path(@book[0].id)
      else
        @connect = Archive.create(:user_id => current_user.id, :book_id => @book[0].id, :status => params[:status])
        redirect_to(book_path(@book[0].id), :notice => "You just added this book to your collection")
      end
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
