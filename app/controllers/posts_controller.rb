class PostsController < ApplicationController

  before_action :require_sign_in, except: :show
  before_action :authorize_user, except: [:show, :new, :create]

  def show
    @post = Post.find(params[:id])
    @topics = Topic.visible_to(current_user)
  end

  def new
    @topics = Topic.visible_to(current_user)
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    if @post.save
      @post.labels = Label.update_labels(params[:post][:labels])
      redirect_to [@topic, @post]
    else
      render :new
    end
  end

  def edit
    @topics = Topic.visible_to(current_user)
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      @post.labels = Label.update_labels(params[:post][:labels])
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

  def authorize_user
    post = Post.find(params[:id])
    unless current_user == post.user || current_user.admin?
      flash[:alert] = "You must be an admin to do that"
      redirect_to [post.topic, post]
    end
  end
end
