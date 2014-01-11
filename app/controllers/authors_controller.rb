class AuthorsController < ApplicationController
  before_action :set_author, only: [:show]
  
  def index
  end
  
  def show
    @works = @author.books
  end
  
  private
  
  def set_author
    @author = Author.find(params[:id])
  end
end