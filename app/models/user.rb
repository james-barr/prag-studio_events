class User < ApplicationRecord
  has_many :registrations, dependent: :destroy

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A\S+@\S+\z/ }
  validates :username, presence: true,
                      format: { with: /\A[a-zA-Z\d]+\z/i, message: "Letters and numbers, only."},
                      uniqueness: { case_sensitive: false }

  def self.authenticate(email_or_username, password)
    user = User.find_by(email: email_or_username) || User.find_by(username: email_or_username)
    user && user.authenticate(password)
  end
end
