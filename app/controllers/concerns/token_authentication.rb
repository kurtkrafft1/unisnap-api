module TokenAuthentication
    extend ActiveSupport::Concern
  
    included do
      skip_before_action :verify_authenticity_token
      prepend_before_action :authenticate_user_from_token
      protect_from_forgery prepend: true, with: :null_session
    end
  
    protected
      def authenticate_user_from_token
        authenticate_or_request_with_http_token do |token, options|
          if (user = User.find_by(email: options[:email])) && Devise.secure_compare(user.authentication_token, token)
            warden.request.env['devise.skip_trackable'] = true
            sign_in user, store: false
            user
          else
            puts "false"
            false
          end
        end
      end
  
      def set_devise_scope
        request.env['devise.mapping'] = Devise.mappings[:user]
      end
  end
  