class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:create, :accept]

  def create
    unless current_user.member?(@group)
      @membership = current_user.join!(@group)

      unless @membership.approved?
        redirect_to groups_path, notice: "You'll be notified when you're accepted to the group."
      else
        redirect_to @group
      end
    else
      redirect_to @group, alert: 'You are already a member of this group. Silly.'
    end
  end

  def accept
    @membership = Membership.find(params[:id])
    @user = @membership.user

    if @group.owner?(current_user)# && !@user.member?(@group)
      if @group.accept!(@membership)
        # Notifier.some_mailer_method(@user)
        redirect_to @group, notice: "#{@user.name} has been accepted & notified about joining the group."
      else
        redirect_to @group, alert: 'Something went wrong. Try again.'
      end
    else
      redirect_to @group, alert: "You don't have permission to do that."
    end
  end

  def decline
  end

  def leave
     @membership = Membership.find params[:id]

    if current_user.member?(@membership.group) && @membership.group.owner?(current_user)
      if @membership.user.leave!(@membership.group)
        redirect_to groups_path, notice: "You've left the group successfully."
      else
        redirect_to @membership.group, alert: 'Something went wrong. Try again.'
      end
    else
      redirect_to @membership.group, alert: "You don't have permission to do that."
    end
  end

  def destroy
    @membership = Membership.find params[:id]

    if @membership.group.owner?(current_user)
      if @membership.user.leave!(@membership.group)
        redirect_to groups_path, notice: "This user has been removed from the group."
      else
        redirect_to @membership.group, alert: 'Something went wrong. Try again.'
      end
    else
      redirect_to @membership.group, alert: "You don't have permission to do that."
    end
  end

  private

  def set_group
    @group = Group.find params[:group_id]
  end
end
