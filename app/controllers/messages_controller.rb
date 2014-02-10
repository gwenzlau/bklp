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

  def destroy
  	@message = Message.find(params[:id])
  	@conversation = @message.conversation

  	respond_to do |format|
      if @message.destroy! && @message.user == current_user
        @conversation.destroy if @conversation.messages.count == 0
        format.html { redirect_to @conversation, flash: { success: "Message deleted."} }
      else
        format.html { redirect_to @conversation, flash: { error: "The message couldn't be deleted!"} }
      end

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
