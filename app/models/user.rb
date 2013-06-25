class User < ActiveRecord::Base
    attr_accessible :email, :name, :password, :password_confirmation
    before_save :create_remember_token

    has_secure_password

    before_save { |user| user.email = email.downcase }

    validates :name, presence: true, length: { maximum: 50 }
    VALID_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_FORMAT }, uniqueness: { case_sensitivity: false }
    validates :password, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true

    private
        def create_remember_token
            self.remember_token = SecureRandom.urlsafe_base64
        end
end
