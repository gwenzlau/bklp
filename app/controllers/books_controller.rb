class BooksController < ApplicationController
	def index
    @books = Book.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    # Start a new session
    client = Goodreads.new(Goodreads.configuration)
    
    # Get the metadata from Goodreads
    @thebook = client.book(params[:id]) unless client.book(params[:id]).blank?
  
    # If user logged in, get user data and initialize new instance for the option to start reading the book.
    if user_signed_in?
      @newbook = Book.new
      @mybook = Book.where(:user_id => current_user.id).where(:olidb => params[:id])
      @user = current_user
    end
    
    #Users currently reading this book
    @users_reading = Book.where(:olidb => params[:id]).where(:status => "0")
    @review = Review.where(:book_id => params[:id])

    
    
    #This will pick up 5 random books by users who have read the current book beeing viewd
    also = Book.select(:user_id).uniq.where(:olidb => params[:id])
    @also_read = Book.where(user_id: also).where(:status => "1").limit(4).order("RANDOM()")

  end
  
  def author
    client = Goodreads.new(Goodreads.configuration)
    @theauthor = client.author(params[:id])
    @authorbooks = client.search_books(@theauthor.name)
    @user = current_user
  end


  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  
  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    #@book = Book.new(params[:book])
    
    if @book.save
      redirect_to current_user
    else
      redirect_to root_path
    end
    #@book = Book.new(params[:book])

    #respond_to do |format|
     # if @book.save
      #  format.html { redirect_to @book, notice: 'Here is the book page.' }
       # format.json { render json: @book, status: :created, location: @book }
    #  else
     #   format.html { render action: "onew" }
      #  format.json { render json: @book.errors, status: :unprocessable_entity }
    #  end
  #  end
  end
  
  def book_readit
    @book = Book.new(book_params)
    #@book = Book.new(params[:book])
    
    if @book.save
      redirect_to current_user
    else
      redirect_to root_path
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.friendly.find(params[:id])
    #@book.create_activity :book_readit

    if @book.update_attribute(:status, "1")
      redirect_to finished_path(:id => @book.olidb)
    else
      redirect_to root_path
    end
  end

  def order
    @book = Book.friendly.find(params[:id])
    if @book.update_attribute(:order)
      redirect_to current_user
    else 
    end

  end

  def future_list
    @future = Book.new(book_params)
    @future.activity key: 'book.future_list'
    
    if @future.save
      redirect_to current_user
    else
      redirect_to root_path
    end
  end
  
  def start_future_read
    @book = Book.find(params[:id])
    @book.activity key: 'book.future_read'

    if @book.update_attribute(:status, "0")
      redirect_to current_user
    else
      redirect_to root_path
    end
  end

  def past_list
    @past = Book.new(book_params)
    @past.activity key: 'book.past_list'
    
    if @past.save
      redirect_to current_user
    else
      redirect_to root_path
    end
  end

  def recommend_list
  @recommend = Book.find(params[:id])
  @recommend.activity key: 'book.recommend_list'
  if @recommend.update_attribute(:recommend, "true")
      redirect_to current_user
    else
      redirect_to root_path
    end
  end

  def rec_list
  @rec = Book.find(params[:id])
  @rec.activity key: 'book.rec_list'
  if @rec.update_attribute(:rec, "true")
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

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :author, :olida, :olidb, :user_id, :status, :rec, :recommend, :order, :isbn)
  end
end
