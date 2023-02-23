class Api::V1::SessionsController < ::Devise::SessionsController
    skip_before_action :verify_authenticity_token
    respond_to :json
    
    def create
        user = User.find_by(email: params[:email])
        if user && user.valid_password?(params[:password])
        user.setup_authentication
        render json: user, status: 200
        else
        render json: { errors: 'Invalid email or password' }, status: 422
        end
    end

    def register
        user = User.find_by(email: params[:email])
        if user && user.valid_password?(params[:password])
        render json: user, status: 201
        else
        user = User.create(email: params[:email], password: params[:password])
        user.save!
        render json: user, status: 200
        end
    end
    
    def destroy
        sign_out(current_user)
        head 204
    end
end
