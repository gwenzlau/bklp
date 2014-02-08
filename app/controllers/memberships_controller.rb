class MembershipsController < ApplicationController
  before_action :set_group

  def create
    @membership = current_user.join!(@group)

    unless @membership.approved?
      redirect_to groups_path, notice: "You'll be notified when you're accepted to the group."
    else
      redirect_to @group
    end
  end

  def accept
    if @group.accept!(params[:user_id])
      redirect_to @group, notice: 'User accepted & notified.'
    else
      redirect_to @group, alert: 'Something went wrong. Try again.'
    end
  end

  def decline
  end

  def cancel
  end

  def destroy
    @membership = Membership.find params[:id]
    @membership.user.leave!(@group)
  end

  private

  def set_group
    @group = Group.find params[:group_id]
  end
end
