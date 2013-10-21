class PagesController < ApplicationController
  
  def home
  end

  def action
  end
  
  def search
    client = Openlibrary::Client.new
    @results = client.search(params[:q])
  end
end
