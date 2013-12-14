class ActivitiesController < ApplicationController
  def index
  	@activities = PublicActivity::Activity.order("created_at desc").paginate(:page => params[:page], :per_page => 10)

  	respond_to do |format|
  		format.html
  		format.json { render json: @activities }
  		format.js
  end
end
