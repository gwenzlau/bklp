class MessagesController < ApplicationController
	before_action :authenticate_user!

  def create
  	@message = Message.new(message_params)
		@message.user = current_user
  	@message.conversation = Conversation.find(params[:conversation_id])
  	@message.save

  	respond_to do |format|
  		format.html { redirect_to conversation_path(@message.conversation) }
  		format.js
  	end
  end

  protected

  def message_params
    params.require(:message)
      .permit(
        :body
      )
  end
end
