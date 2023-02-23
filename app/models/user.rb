class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def setup_authentication
    self.authentication_token = Devise.friendly_token[0, 20]
    self.authentication_token_created_at = Time.now
    self.save!
  end
end
