class User < ActiveRecord::Base
  max_paginates_per 10

  has_many :reviews

  has_secure_password

  validates :email,
    presence: true

  validates :firstname,
    presence: true

  validates :lastname,
    presence: true

  validates :password,
    length: { in: 6..20 }, on: :create

  mount_uploader :avatar, AvatarUploader

  def full_name
    "#{firstname} #{lastname}"
  end

end