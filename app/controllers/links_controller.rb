class LinksController < ApplicationController
  before_action :set_link, only: [:show, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

	def index
    @links = Link.all.order("created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @links }
    end
  end

  def create
    @link = Link.new(link_params)
    
    if @link.save
      redirect_to current_user
    else
      redirect_to root_path
    end
  end

  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link }
    end
  end

  def show
  end

  def link_readit
   @link = Link.new(link_params)
    
   	if @link.save
     redirect_to current_user
    else
    redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @link.update(link_params)
      redirect_to @link, notice: 'Link updated!'
    else
      render action: 'edit'
    end
  end

  def destroy
    @link.destroy
    redirect_to root_path
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def correct_user
    @link = current_user.links.find_by(id: params[:id])
    redirect_to root_path, notice: "You cannot edit this link" if @link.nil?
  end
  
  private
    
  def link_params
    params.require(:link).permit(:source, :title, :user_id)
  end
end
