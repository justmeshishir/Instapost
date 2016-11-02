class UpvotesController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @post = Post.find(params[:post_id]) 
        @post.liked_by current_user

        respond_to do |format|
           format.html { redirect_to posts_path }
           format.js { render :layout => false }
        end
    end
end
