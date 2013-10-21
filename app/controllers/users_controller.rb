class UsersController < ApplicationController
  
	def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
     end
   end
   
	def show
		@user = User.find(params[:id])
    
    # Users are reading now and have previously read:
    @book = Book.where(:user_id => params[:id]).where.not(:status => "1")
    @past = Book.where(:user_id => params[:id]).where(:status => "1")
    @future = Book.where(:user_id => params[:id]).where(:status => "2")
	end
  
end
