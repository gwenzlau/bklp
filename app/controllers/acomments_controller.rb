class AcommentsController < ApplicationController

  def index
  end
  
  def create
    @acomment = Acomment.new(acomment_params)
    if @acomment.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
  
  def destroy
  end
  
  private
  
  def acomment_params
    params.require(:acomment).permit(:activity_id, :user_id, :comment)
  end
end