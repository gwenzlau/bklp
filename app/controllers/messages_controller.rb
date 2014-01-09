class MessagesController < ApplicationController
	before_action :authenticate_user!

  def create
  	@message.user = current_user
  	@message.conversation = @conversation
  	@message.save

  	respond_to do |format|
  		format.html { redirect_to conversation_path(@message.conversation) }§
  		format.js
  	end
  end
end
