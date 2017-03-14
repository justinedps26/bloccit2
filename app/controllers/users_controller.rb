class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.avatar = params[:user][:avatar]
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      create_session(@user)
      redirect_to topics_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again later."
      render :new
    end
   end

   def show
     @user = User.find(params[:id])
     @posts = @user.posts.visible_to(current_user)
   end
end
