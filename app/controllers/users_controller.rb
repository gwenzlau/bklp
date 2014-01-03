class UsersController < ApplicationController
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
    if signed_in?
      @acomment = Acomment.new
      @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: params[:id], owner_type: "User").limit(10)
    end
    @client = Goodreads.new(Goodreads.configuration)
		@user = User.find(params[:id])
    
    # Users are reading now and have previously read:
    @book = Book.where(:user_id => params[:id]).where(:status => "0")
    #@booka = @book.map(&:title) 
    @past = Book.where(:user_id => params[:id]).where(:status => "1").limit(10).order("updated_at desc")

    @future = Book.where(:user_id => params[:id]).where(:status => "2").limit(10).order("updated_at desc")

    @link = Link.where(:user_id => params[:id]).where(:status => "0")

    
    @link = Link.where(:user_id => params[:id])
    @pastlink = Link.where(:user_id => params[:id]).where(:status => "1")
    @futurelink = Link.where(:user_id => params[:id]).where(:status => "2")

    #Recommended books and authors
    @recommended_books = Recommend.where(:user_id => params[:id]).where(:item_type => "book").limit(4).order("RANDOM()")
    @recommended_authors = Recommend.where(:user_id => params[:id]).where(:item_type => "author").limit(6).order("RANDOM()")

    @order = Book.where(:user_id => params[:id])
  end

  def pastreads
    @user = User.find(params[:id])
    @client = Goodreads.new(Goodreads.configuration)
    @book = Book.where(:user_id => params[:id]).where(:status => "0")
    @past = Book.where(:user_id => params[:id]).where(:status => "1")
  end

  def futurereads
    @user = User.find(params[:id])
    @client = Goodreads.new(Goodreads.configuration)
    @book = Book.where(:user_id => params[:id]).where(:status => "0")
    @future = Book.order(params[:order]).where(:user_id => params[:id]).where(:status => "2")
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


end
