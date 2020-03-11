class User < ApplicationRecord
  has_secure_password

  has_secure_token :confirmation_token
  has_secure_token :recover_password

  has_many :notes

  validates :username,
            format: { with: /\A[a-zA-Z0-9_]{2,20}\z/, message: "doit contenir des caractères alphanumériques ou _" },
            uniqueness: {case_sensitive: false}
  validates :email,
            format: {with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/},
            uniqueness: {case_sensitive: false}

  def to_session
    {id: id}
  end
end