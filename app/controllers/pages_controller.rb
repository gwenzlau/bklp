class PagesController < ApplicationController
  
  def home
    # Show the feed of the users you are following. Limits the list to latest 10 feeds
    if signed_in?
      @acomment = Acomment.new
      @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.following_users, owner_type: "User").paginate(:page => params[:page], :per_page => 10)
      @user = current_user
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
    respond_to do |format|
      format.json  { render :json => books }
    end
  end 


end
