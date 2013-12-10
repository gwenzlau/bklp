class API::CommentariesController < ApplicationController
  include APIHelper

  protect_from_forgery except: [:create, :update, :destroy]

  before_action :authenticate_user!
  before_action :set_commentary, only: [:update, :destroy]

  def create
    @commentary = current_user.commentaries.new(commentary_params)
    @commentary.discussion_id = params[:discussion_id]

    if @commentary.save
      render json: to_json({ success: true, commentary: @commentary.public_params })
    else
      render json: to_json({ success: false, errors: @commentary.errors, commentary: @commentary })
    end
  end

  def update
    if @commentary.update_attributes(commentary_params)
      render json: to_json({ success: true, commentary: @commentary.public_params })
    else
      render json: to_json({ success: false, errors: @commentary.errors, commentary: @commentary })
    end
  end

  def destroy
    if @commentary.destroy
      render json: to_json({ success: true, commentary: @commentary.public_params })
    else
      render json: to_json({ success: false, errors: "You don't have permission to delete this." })
    end
  end

private
  def set_commentary
    @commentary = current_user.commentaries.find(params[:id])
  end

  def commentary_params
    params.require(:commentary).permit(:message)
  end
end
