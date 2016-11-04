class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    before_action :is_owner?, only: [:edit, :update, :destroy]
    def new
        @post = Post.new
    end
    
    def show
      @post = Post.find(params[:id])  
    end
    
    def index
      @posts = Post.all.order("created_at DESC").includes(:user, comments: :user) unless user_signed_in?
      @posts = Post.of_followed_users(current_user.following).order("created_at DESC").includes(:user, comments: :user) if user_signed_in?
    end
    
    def create
      @post = current_user.posts.create(post_params)
      return "Sorry" if @post.extension_white_list == false
      if @post.valid?
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    end
    
    def edit
      @post = Post.find(params[:id])
    end
    
    def update
      @post = Post.find(params[:id])
      @post.update(post_params)
      if @post.valid?
        redirect_to root_path
      else
        render :edit, status: :unprocessable_entity
      end
    end
    
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to root_path
    end
    
    private

    def post_params
        params.require(:post).permit(:user_id, :photo, :description)
    end
    
    def is_owner?
      redirect_to root_path if Post.find(params[:id]).user != current_user
    end
    
    def extension_white_list
      %w(jpg jpeg gif png)
    end
end
