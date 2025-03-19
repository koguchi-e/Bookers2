class RelationshipsController < ApplicationController
    def createt
        user = User.find(params[:user_id])
        current_user.follow(user)
        redirect_to requesr.referer
    end

    def destroy
    end
end
