class API::DiscussionsController < ApplicationController
  protect_from_forgery except: :create

  before_action :authenticate_user!

  def index
    discussions = Discussion.where(book_id: params[:book_id]).includes(:commentaries)

    render json: { success: true, discussions: discussions.to_a }
  end

  def create
    discussion = Discussion.new(discussion_params)
    discussion.book_id = params[:book_id]

    if discussion.save
      render json: { success: true, discussion: discussion }
    else
      render json: { success: false, errors: discussion.errors, discussion: discussion }
    end
  end

private
  def discussion_params
    params.require(:discussion).permit(:quote, :page, :pages_total)
  end
end
