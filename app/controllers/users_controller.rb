class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

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

   private

   def user_params
     params.require(:user).permit(:avatar, :name, :email, :password, :password_confirmation)
   end

end
