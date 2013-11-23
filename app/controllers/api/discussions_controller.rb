class API::DiscussionsController < ApplicationController
  protect_from_forgery except: [:create, :update, :destroy]

  before_action :authenticate_user!
  before_action :set_discussion, only: [:update, :destroy]

  def index
    book = Book.find_by!(olidb: params[:book_id])

    render json: { success: true, discussions: book.discussions }
  end

  def create
  end

  def update
  end

  def destroy
  end

private
  def set_discussion
    @disucssion = Discussion.find(params[:id])
  end

  def discussion_params
    params.require(:disucssion).permit(:quote)
  end
end
