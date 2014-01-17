class PagesController < ApplicationController
  
  def home
    # Show the feed of the users you are following. Limits the list to latest 10 feeds
    if signed_in?
      @acomment = Acomment.new
      @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.following_users, owner_type: "User").paginate(:page => params[:page], :per_page => 10)
      @user = current_user
      @book_current = current_user.archives.where(:status => "0")
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def action
  end
  
  def search
    @results = Book.find(:all, :conditions => ['title LIKE ?', params[:search]])
  end

end
