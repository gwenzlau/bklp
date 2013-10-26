class PagesController < ApplicationController
  
  def home
    # Show the feed of the users you are following. Limits the list to latest 10 feeds
    if signed_in?
      @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.following_users, owner_type: "User").limit(20)
    end
  end

  def action
  end
  
  def search
    client = Openlibrary::Client.new
    @results = client.search(params[:q])
  end
end
