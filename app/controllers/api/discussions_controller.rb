class API::DiscussionsController < ApplicationController
  include APIHelper

  protect_from_forgery except: :create

  before_action :authenticate_user!

  def index
    discussions = Discussion.includes(:commentaries).where(book_id: params[:book_id])

    render json: to_json(discussions.map(&:public_params))
  end

  def show
    discussion = Discussion.find(params[:id])

    render json: to_json(discussion.public_params)
  end

  def create
    discussion = Discussion.new(discussion_params)
    discussion.book_id = params[:book_id]

    if discussion.save
      render json: to_json(discussion.public_params)
    else
      render json: to_json({ errors: discussion.errors, discussion: discussion })
    end
  end

private
  def discussion_params
    params.require(:discussion).permit(:quote, :page, :pages_total)
  end
end
