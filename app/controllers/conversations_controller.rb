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
    @conversation = Conversation.new(conversation_params)    

    if @conversation.save
      redirect_to conversation_path @conversation
    else
      render action: :new
    end
  end

  def destroy
  end

  protected

  def conversation_params
    params.require(:conversation)
      .permit(
        messages_attributes: [
          :id,
          :body,
          :user_id
        ],
        # participants_attributes: [
        #   :id,
        #   :conversation_id,
        #   :user_id
        # ]
      )
  end
end
