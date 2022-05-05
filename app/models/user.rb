class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true

  # has_many :tweets, :through => :likes
  has_many :likes, dependent: :destroy
  has_many :tweets, dependent: :destroy

  has_one_attached :avatar

  enum :role, { member: 0, admin: 1 }

  def self.from_omniauth(auth_hash)
    where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create do |user|
      user.provider = auth_hash.provider
      user.uid = auth_hash.uid
      user.username = auth_hash.info.nickname
      user.email = auth_hash.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
