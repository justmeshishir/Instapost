class CommentsController < ApplicationController
    before_action :authenticate_user!, only: :create
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comment.create(comment_params.merge(user_id: current_user.id))
        if @comment.valid?
            redirect_to root_path
        else
            flash[:alert] = "Invalid Attributes"
            redirect_to root_path
        end
    end
    
    private
    def comment_params
        params.require(:comment).permit(:text, :post_id)
    end
end
