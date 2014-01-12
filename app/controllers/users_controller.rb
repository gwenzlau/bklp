class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :readlist_future, :readlist_past]
  
  def create
    # Create the user from params
    @user = User.new(params[:user])
    if @user.save
      # Deliver the signup email
      Notifier.send_signup_email(@user).deliver
      redirect_to(@user, :notice => 'Welcome!')
    else
      render :action => 'index'
    end
  end

	def index
    @users = User.order("created_at desc").paginate(:page => params[:page], :per_page => 50)
    @user = current_user
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
     end
   end

	def show
    @book_current = User.find(params[:id]).archives.where(:status => "0")
    @book_past= User.find(params[:id]).books.where(:status => "1").limit(10).order("updated_at DESC")
    @book_future= User.find(params[:id]).books.where(:status => "2").limit(10).order("updated_at DESC")
    
    @recommended_books = User.find(params[:id]).recommends.where(:item_type => "book")
    @recommended_authors = User.find(params[:id]).recommends.where(:item_type => "author")
    
    if signed_in?
      @new_comment = Acomment.new
    end
  end

  def readlist_past
    @books = current_user.archives
  end

  def readlist_future
    @books = current_user.archives
    #@future = Book.order(params[:order]).where(:user_id => params[:id]).where(:status => "2")
  end

  def recommendations
    @user = User.find(params[:id])
    @client = Goodreads.new(Goodreads.configuration)
    @book = Book.where(:user_id => params[:id]).where(:status => "0")
     @recommended_books = Recommend.where(:user_id => params[:id]).where(:item_type => "book").limit(4).order("RANDOM()")
    @recommended_authors = Recommend.where(:user_id => params[:id]).where(:item_type => "author").limit(6).order("RANDOM()")

  end

  def follow
    @user = User.find(params[:id])
    if current_user
     if current_user == @user
      flash[:error] = "You cannot follow yourself."
      redirect_to current_user
     else
      current_user.follow(@user)
      redirect_to current_user
     # RecommenderMailer.new_follower(@user).deliver if @user.notify_new_follower
      flash[:notice] = "You are now following #{@user.name}."
      end
  else
    flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.name}.".html_safe
    redirect_to root_path
  end
end

def unfollow
  @user = User.find(params[:id])

  if current_user
    current_user.stop_following(@user)
    flash[:notice] = "You are no longer following #{@user.name}."
    redirect_to root_path
  else
    flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.name}.".html_safe
    redirect_to root_path
  end
end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
