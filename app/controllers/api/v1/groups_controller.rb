class Api::V1::GroupsController < ApplicationController
    include TokenAuthentication

    def create
        group = Group.new(name: params[:name], user_id: current_user.id)
        if group.save
            render json: group, status: 200
        else
            render json: { errors: group.errors.full_messages }, status: 422
        end
    end

    def index
        groups = current_user.fetch_user_groups 
        render json: groups, status: 200
    end
end
