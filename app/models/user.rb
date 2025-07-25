class User < ApplicationRecord
  has_many :identities, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true

  def self.from_omniauth(auth)
    # First, find or create the identity
    identity = Identity.find_or_create_by(provider: auth.provider, uid: auth.uid) do |id|
      # If creating a new identity, find or create the user by email
      user = User.find_or_create_by(email: auth.info.email) do |u|
        u.name = auth.info.name || auth.info.nickname || "User"
      end
      id.user = user
    end
    
    # Update user name if it's better than what we have
    if identity.user.name.blank? || identity.user.name == "User"
      identity.user.update(name: auth.info.name || auth.info.nickname || identity.user.name)
    end
    
    identity.user
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "OAuth authentication failed: #{e.message}"
    nil
  end
  
  def connected_providers
    identities.pluck(:provider)
  end
  
  def provider_connected?(provider)
    identities.exists?(provider: provider)
  end
end
