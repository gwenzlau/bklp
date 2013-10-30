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

    if user_signed_in?
      @newlink = Link.new
      @mylink = Link.where(:user_id => current_user.id).where(:id => params[:id])
    end

    #other readers
    @users_read = Link.where(:id => params[:id]).where(:status => "1")
  end

  def link_readit
   @link = Link.new(link_params)
    
   	if @link.save
     redirect_to current_user
    else
    redirect_to root_path
    end
  end

  def pastlink_list
    @pastlink = Link.new(link_params)
    @pastlink.activity key: 'link.pastlink_list'

    if @pastlink.save
      redirect_to current_user
    else
      redirect_to root_path
    end
  end

  def futurelink_list
    @futurelink = Link.new(link_params)
    @futurelink.activity key: 'link.futurelink_list'

    if @futurelink.save
      redirect_to current_user
    else
      redirect_to root_path
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attribute(:status, "1")
      redirect_to current_user
    else
      redirect_to root_path
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
    params.require(:link).permit(:source, :title, :user_id, :status)
  end
end
