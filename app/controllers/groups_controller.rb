class GroupsController < ApplicationController
	before_action :authenticate_user!

  def index
  	@groups = Group.where(private: false)
  end

  def new
  	@group = Group.new
  end

  def create
  end

  def show
  	@group = Group.find params[:id]
  end

  def destroy
  end
end
