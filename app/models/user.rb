class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :provider, presence: true
  validates :uid, presence: true
  validates :uid, uniqueness: { scope: :provider }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name || auth.info.nickname || "User"
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "OAuth authentication failed: #{e.message}"
    nil
  end
end
