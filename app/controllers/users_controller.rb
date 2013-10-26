class UsersController < ApplicationController
  
	def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
     end
   end
   
	def show
    if signed_in?
      @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: params[:id], owner_type: "User").limit(10)
    end
    
		@user = User.find(params[:id])
    
    # Users are reading now and have previously read:
    @book = Book.where(:user_id => params[:id]).where(:status => "0")
    #@booka = @book.map(&:title) 
    @past = Book.where(:user_id => params[:id]).where(:status => "1")
    @future = Book.where(:user_id => params[:id]).where(:status => "2")
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
