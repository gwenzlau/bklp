class RecommendsController < ApplicationController
  
  def show
  end
  
  def create
  end
  
  def destroy
  end
  
  def update
  end
  
  def top_book
    client = Goodreads.new(Goodreads.configuration)
    @top_books = Recommend.where(:item_type => "book").count(:group => :item_id, :order => "count_all DESC")
  end
  
  def top_author
    client = Goodreads.new(Goodreads.configuration)
    @top_author = Recommend.where(:item_type => "author").count(:group => :item_id, :order => "count_all DESC")
  end
end