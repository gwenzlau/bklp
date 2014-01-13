class GroupsController < ApplicationController
	before_action :authenticate_user!

  def index
  	@groups = Group.where(public: true)
  end

  def new
  	@group = Group.new
  end

  def create
  	@group = current_user.groups.build(group_params)

  	if @group.save
  		redirect_to @group
  	else
  		render action: :new
  	end
  end

  def show
  	@group = Group.find params[:id]
  end

  def destroy
    @group = Group.find params[:id]

    if @group.user == current_user
      @group.destroy

      redirect_to groups_path
    else
      redirect_to @group, notice: "Failed to delete group"
    end
  end

  protected

  def group_params
    params.require(:group)
      .permit(
        :title,
        :description,
        :public
      )
  end
end
