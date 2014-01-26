class ArchivesController < ApplicationController
  before_action :set_archive, only: [:update, :destroy]
  
  def create
    @archive = current_user.archives.build(archive_params)
    
    if @archive.save
      redirect_to book_path(id: params[:archive][:book_id])
    else
    end
  end
  
  def update
    if params[:type] == "start"
      @archive.activity key: 'archive.create'
      if @archive.update_attribute(:status, "0")
        redirect_to(book_path(@archive.book_id), :notice => "You started reading this book from your future list")
      else
        redirect_to(root_path, :notice => "An error occured while trying to change status of a book from your future list.")
      end
    else
      @archive.activity key: 'archive.update'
      if @archive.update_attribute(:status, "1")
        redirect_to(book_path(@archive.book_id, :finished => 'true')) 
      else
        redirect_to(book_path(@archive.book_id), :notice => "An error occured while trying to change status of a book you just finished.")
      end
    end
  end
  
  def destroy
    if @archive.destroy
      redirect_to(user_path(current_user), :notice => "You just abandoned a book from your list.")
    else
      redirect_to(book_path(@archive.book_id), :notice => "Could not update status and abandon the selected book")
    end
  end
  
  def past_list
    @past = current_user.archives.build(archive_params)
    @past.activity key: 'book.past_list'
    
    if @past.save
      redirect_to(current_user, :notice => "Just added a book to your past reads list.")
    else
      redirect_to root_path
    end
  end
  
  def future_list
    @future = current_user.archives.build(archive_params)
    @future.activity key: 'book.future_list'
    
    if @future.save
      redirect_to(current_user, :notice => "Just added a book to your future reads list.")
    else
      redirect_to root_path
    end
  end
  
  def finishedmodal
  end

  private
  
  def set_archive
    @archive = Archive.find(params[:id])
  end
  
  def archive_params
    params.require(:archive).permit(:user_id, :book_id, :status)
  end
end
