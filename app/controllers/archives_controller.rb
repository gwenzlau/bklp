class ArchivesController < ApplicationController

  def create
    @archive = current_user.archives.build(archive_params)
    
    if @archive.save
      redirect_to book_path(id: params[:archive][:book_id])
    else
    end
  end
  
  private
  
  def archive_params
    params.require(:archive).permit(:user_id, :book_id, :status)
  end
end
