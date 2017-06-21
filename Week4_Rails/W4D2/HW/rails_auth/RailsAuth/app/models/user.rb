class User < ApplicationRecord
  attr_reader :password

  validates :username, :session_token, presence: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6, allow_nil: true }

  def self.find_by_credentials(username, password)
    @user = User.find_by(username)
  end

  def self.generate_session_token
    @session_token = SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    @session_token = nil
    @user.save
  end

  def ensure_session_token
    User.generate_session_token unless @session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
