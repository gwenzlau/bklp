class LinksController < ApplicationController
	def index
    @links = Link.all

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
    @link = Link.new
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
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])

    if @link.update_attribute(params[:link])
      redirect_to @link
    else
      redirect_to root_path
    end
  end
    
  def link_params
    params.require(:link).permit(:source, :title, :user_id)
  end
end
