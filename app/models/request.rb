class Request < ActiveRecord::Base
    include SessionsHelper
    
    validates :sender, uniqueness: {scope: :receiver}
    
    has_many :messages, -> {order(created_at: :asc) }, dependent: :destroy
    
    scope :participating,
        where("(requests.sender_id = ? OR requests.recipient_id = ?)", current_user.id, current_user.id)
    
    scope :between, lambda(sender_id, recipient_id) do
        where(sender_id: sender_id, recipient_id: recipient_id).or(where(sender_id: recipient_id, recipient_id: sender_id)).limit(1)
    end
    
    def with
        sender == current_user ? recipient : sender
    end
    
    def participates?(user)
        sender == user || recipient == user
    end
end
