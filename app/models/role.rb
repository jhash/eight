class Role < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  validates :name, presence: true, uniqueness: true

  SUPERADMIN = "superadmin"

  def self.superadmin
    find_or_create_by(name: SUPERADMIN)
  end
end
