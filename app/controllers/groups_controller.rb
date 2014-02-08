class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :destroy]

  def index
    @groups = (Group.where(public: true) + current_user.member_of_groups).uniq(&:id)
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)

    if @group.save
      redirect_to @group, notice: 'Group created successfully.'
    else
      render action: :new
    end
  end

  def show
    @status = @group.memberships.find_by(user: current_user)

    unless @group.public? || (@status && @status.approved?)
      @membership = @group.memberships.build
      render 'groups/join'
    else
      @memberships = @group.memberships
    end
  end

  def destroy
    if @group.owner?(current_user)
      @group.destroy

      redirect_to groups_path
    else
      redirect_to @group, notice: "You don't have permission to delete this group."
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

  private

  def set_group
    @group = Group.find params[:id]
  end
end
