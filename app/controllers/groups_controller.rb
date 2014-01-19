class GroupsController < ApplicationController
	before_action :authenticate_user!
  before_action :set_group, except: [:index, :new, :create]

  def index
  	@groups = Group.all
  end

  def new
  	@group = Group.new
  end

  def create
  	@group = current_user.groups.build(group_params)

  	if @group.save
  		redirect_to @group, notice: 'Your group has been made successfully.'
  	else
  		render action: :new
  	end
  end

  def show
    @books = @group.books
    @discussions = @group.discussions

    @join_status = @group.member?(current_user)

    redirect_to join_request_group_path unless @group.public? || @join_status

    @members = @group.group_users.where(approved: true)
    @requests = @group.group_users.where(approved: nil)
  end

  def destroy
    if @group.user == current_user
      @group.destroy

      redirect_to groups_path
    else
      redirect_to @group, notice: "Failed to delete group"
    end
  end

  def join_request
  end

  def do_join_request
    @group_user = GroupUser.new
    @group_user.group_id = params[:id]
    @group_user.user_id = params[:user_id]
    @group_user.approved = true if @group.public?
    @group_user.save

    if @group_user.approved?
      redirect_to @group, notice: 'Joined successfully.'
    else
      redirect_to groups_path, notice: "Your request to join #{@group.title} has been received."
    end
  end

  def accept_join_request
    @group_user = GroupUser.find_by(user_id: params[:user_id], group_id: params[:id])
    @group_user.approved = true
    @group_user.save

    redirect_to @group, notice: 'User is now part of the group.'
  end

  def decline_join_request
    @group_user = GroupUser.find_by(user_id: params[:user_id], group_id: params[:id])
    @group_user.destroy

    redirect_to @group, notice: 'You declined the user joining.'
  end

  def cancel_join_request
    @group_user = GroupUser.find_by(user_id: params[:user_id], group_id: params[:id])
    
    if @group_user.user == current_user
      @group_user.destroy
      redirect_to groups_path, notice: "You're no longer part of the group."
    else
      redirect_to @group, notice: "You can't cancel that request."
    end
  end

  def remove_member
    @group_user = GroupUser.find_by(user_id: params[:user_id], group_id: params[:id])
    
    if @group_user == @group.owned_by?(@group_user)
      redirect_to @group, alert: "You own this group. You can't remove yourself"
    else
      @group_user.destroy
      redirect_to @group, notice: 'Removed successfully.'
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
