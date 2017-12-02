class User < ActiveRecord::Base
    belongs_to :request
    belongs_to :user
    
    validates :body, presence: true
end