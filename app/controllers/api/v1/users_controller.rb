class Api::V1::UsersController < ApplicationController
    include TokenAuthentication
    
    def me
        # return the current user as json
        render json: current_user
    end
end
