class Api::V1::InvitesController < ApplicationController
    include TokenAuthentication

    def create
    invite = Invite.new(group_id: params[:group_id], user_id: params[:user_id], inviter_id: current_user.id)
        if invite.save
            render json: invite, status: 200
        else
            render json: { errors: group.errors.full_messages }, status: 422
        end
    end

    def index
    invites = current_user.fetch_invites
        render json: invites, status: 200
    end
end
