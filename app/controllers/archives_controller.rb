class ArchivesController < ApplicationController

  def create
    @archive = current_user.archives.build(archive_params)
    
    if @archive.save
      redirect_to book_path(id: params[:archive][:book_id])
    else
    end
  end
  
  def update
    @archive = Archive.find(params[:id])
    
    if @archive.update_attribute(:status, "0")
      @book = Archive.find(params[:id])
      redirect_to(book_path(@book.book_id), :notice => "You started reading a book from your future list")
    else
      redirect_to(root_path, :notice => "An error occured while trying to change status of a book from your future list")
    end
  end
  
  private
  
  def archive_params
    params.require(:archive).permit(:user_id, :book_id, :status)
  end
end
