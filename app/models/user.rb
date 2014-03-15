# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  name            :string(255)
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :username, :name, :password, :password_confirmation

  has_many :articles

  has_secure_password

  VALID_USERNAME_REGEX = /\A[a-zA-Z]+[a-zA-Z\d\-_]+\z/
  validates :username, presence: true, length: { maximum: 20 },
                       format: { with: VALID_USERNAME_REGEX },
                       uniqueness: { case_sensitive: false }

  validates :name, length: { maximum: 50 }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  after_validation { self.errors.messages.delete(:password_digest) }

  before_save { username.downcase! }
  before_save { name.squish! if name }
  before_save :create_remember_token

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
