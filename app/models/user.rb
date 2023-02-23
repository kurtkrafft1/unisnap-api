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

  def fetch_user_groups
    group_members = GroupMember.where(user_id: self.id)
    group_ids = group_members.map { |group_member| group_member.group_id }
    Group.where(id: group_ids)
  end 

  def fetch_invites
    Invite.where(user_id: self.id).not_accepted
  end
end
