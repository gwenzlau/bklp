class AuthorsController < ApplicationController
  before_action :set_author, only: [:show]
  before_action :set_api, only: [:goodread_search]
  
  def index
  end
  
  def show
    @works = @author.books
  end
  
  def goodread_search
    @gr_result = @client.search_books(params[:search])
  end
  
  private
  
  def set_author
    @author = Author.find(params[:id])
  end
  
  def set_api
    @client = Goodreads.new(Goodreads.configuration)
  end
  
  def book_params
    params.require(:author).permit(:name, :description)
  end
end