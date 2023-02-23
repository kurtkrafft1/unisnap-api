class ApplicationController < ActionController::Base
    include Pundit::Authorization
    
    def authenticate_user_from_token!
        user_email = request.headers["email"].presence
        user_auth_token = request.headers["Token"].presence
        puts "user_email: #{user_email}"
        puts "user_auth_token: #{user_auth_token}"
        user = user_email && User.find_by_email(user_email)
        if user && Devise.secure_compare(user.authentication_token, user_auth_token)
          sign_in(user, store: false)
        end
      end

      rescue_from(Pundit::NotAuthorizedError) { render json: { error: 'Not authorized' }, status: :forbidden }
end
