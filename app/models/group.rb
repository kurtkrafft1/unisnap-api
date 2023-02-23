class Group < ApplicationRecord
    after_create :save_creator_as_group_member
   

    def save_creator_as_group_member
        GroupMember.create(group_id: self.id, user_id: self.user_id)
    end
end