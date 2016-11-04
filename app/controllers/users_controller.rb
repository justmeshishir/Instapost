class UsersController < ApplicationController
    def show
       @user = User.find(params[:id]) 
       redirect_to root_path if @user.nil?
    end
    
    def follow(user_id)  
        following_relationships.create(following_id: user_id)
    end

    def unfollow(user_id)
        following_relationships.find_by(following_id: user_id).destroy
    end
end
