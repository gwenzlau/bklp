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
    @conversation = current_user.conversations.build
    @conversation.messages.build
  end

  def create
    @conversation = current_user.conversations.build(conversation_params)    

    if @conversation.save

      @participant = Participant.new
      @participant.user_id = params[:recipient_id]
      @participant.conversation = @conversation
      @participant.save

      redirect_to conversation_path @conversation
    else
      render action: :new
    end
  end

  def destroy
    @conversation = Conversation.find params[:id]
    
    if @conversation.owner?(current_user)
      @conversation.destroy

      # Redirect, destroy wouldn't really fail
      redirect_to conversations_path, :notice => "Conversation & messages deleted successfully."
    else
      redirect_to root_path, :notice => "You don't have permission to delete this conversation."
    end
  end

  protected

  def conversation_params
    params.require(:conversation)
      .permit(
        messages_attributes: [
          :id,
          :body,
          :user_id
        ]
      )
  end
end
