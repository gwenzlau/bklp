class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@conversations = current_user.conversations
  end

  def show
  	@conversation = current_user.conversations.find(params[:id])
  	@messages = @conversation.messages
  end

  def new
  end

  def destroy
  end
end
