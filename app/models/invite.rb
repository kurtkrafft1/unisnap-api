class Invite < ApplicationRecord
    scope :not_accepted, -> { where(accepted_at: nil) }
end