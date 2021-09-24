class User < ApplicationRecord
    #FIGVAPER
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    after_initialize :ensure_session_token
    attr_reader :password

    has_many :sub_forms,
        foreign_key: :moderator_id,
        class_name: :Sub

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && user.is_password?(password)
            user
        else
            nil
        end
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
    end

end