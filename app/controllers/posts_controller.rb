class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.each_with_index do |post, index|
      if index % 5 == 0
        post.title = "Sensitive Content"
      end
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Your post was saved successfully!"
      redirect_to @post
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
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Your post was updated successfully."
      redirect_to @post
    else
      flash.now[:alert] = "There was an error updating your post. Please try again later."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was successfully deleted."
      redirect_to posts_path
    else
      flash.now[:alert] = "There was an error deleting your post. Please try again later."
      render :show
    end
  end
end
