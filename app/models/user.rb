class User < ApplicationRecord
  has_secure_password

  belongs_to :role

  validates :username, presence: true, uniqueness: true
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role_id, presence: true


  def as_json(opts = {})
    super(opts.merge(only: [:id, :username, :email, :first_name, :last_name, :role_id, :created_at]))
  end
end
