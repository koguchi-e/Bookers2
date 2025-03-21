class RelationshipsController < ApplicationController
    def create
        user = User.find(params[:user_id])
        current_user.follow(user)
        redirect_to request.referer
    end

    def destroy
        user = User.find(params[:user_id])
        current_user.unfollow(user)
        redirect_to request.referer
    end

    def following
        user = User.find(params[:user_id])
        @users = User.following
    end

    def followers
        user = user.find(params[:user_id])
        @users = user.followers
    end
end
