class User < ApplicationRecord
    has_secure_password
    # mount_uploader :avatar, AvatarUploader
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 6 },
              if: -> { new_record? || !password.nil? }

    
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "email", "id", "id_value", "name", "password_digest", "updated_at", "username"]
    end


   
    def generate_password_reset_token
    self.reset_password_token = SecureRandom.hex(32)
    self.reset_password_sent_at = Time.now.utc
    save!
    end
   
end
