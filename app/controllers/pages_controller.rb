class PagesController < ApplicationController
  
  def home
    # Show the feed of the users you are following. Limits the list to latest 10 feeds
    if signed_in?
      flash[:notice] = "<a href='#{edit_user_registration_path}'>You can now update your Profile Picture, add a Website, and a Location to your profile! Click here.</a>".html_safe

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

  def autocomplete
    client = Goodreads.new(Goodreads.configuration)
    results = client.search_books(params[:q])
    books ||= []
    for book in results['results']['work']
      isbn = client.book(book['best_book']['id'])
      books << { 'book' => book['best_book']['title'], 'shortbook' => book['best_book']['title'].parameterize, 'img' => book['best_book']['small_image_url'], 'book_id' => book['best_book']['id'], 'isbn' => isbn.isbn }
    end
    render json: books
  end 

  def discover
    #discover discussion.quote
    @disco = Discussion.limit(1).order("RANDOM()")
    @users = User.limit(1).order("RANDOM()")
    @book_current = current_user.archives.where(:status => "0")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
     end
  end

  def about
  end

   
end
