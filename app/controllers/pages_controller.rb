  class PagesController < ApplicationController
  
  def home
    # Show the feed of the users you are following. Limits the list to latest 10 feeds
    if signed_in?
      @acomment = Acomment.new
      @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.following_users, owner_type: "User").limit(20)
    end
  end

  def action
  end
  
  def search
    client = Goodreads.new(Goodreads.configuration)   
    @results = client.search_books(params[:q])
  end

  def autocomplete
    # autocomplete for search field
    # TODO (ismail):
    # * need to get this working faster
    client = Goodreads.new(Goodreads.configuration)
    results = client.search_books(params[:q])
    books ||= []
    for book in results['results']['work']
      books << book['best_book']['title']
    end
    respond_to do |format|
      format.json  { render :json => books }
    end
  end 


end
