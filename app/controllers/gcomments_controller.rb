class GcommentsController < ApplicationController
  def create
  	@comment = GroupDiscussion.new(gcomment_params)
  	@group = Group.find(params[:group_id])

    @comment.group = @group
    @comment.user = current_user
    
    if @comment.save
  		redirect_to @group, notice: 'Comment added.'
  	else
  		redirect_to @group, alert: 'Something went wrong. Try again.'
  	end
  end

  def destroy
  	@comment = GroupDiscussion.find params[:id]
  	@group = @comment.group

  	if @comment.user == current_user
  		@comment.destroy
  		redirect_to @group, notice: 'Comment deleted.'
  	else
  		redirect_to @group, alert: "You don't have permission to do that."
  	end
  end

  private
  
  def gcomment_params
    params.require(:group_discussion).permit(:group_id, :user_id, :body)
  end
end
