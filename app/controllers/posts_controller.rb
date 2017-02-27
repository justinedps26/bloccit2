class PostsController < ApplicationController

  before_action :require_sign_in, except: :show

  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Your post was saved successfully!"
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving your post. Please try again later."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Your post was updated successfully."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error updating your post. Please try again later."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was successfully deleted."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting your post. Please try again later."
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
