class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
  
  # Validations
  validates :tag_id, uniqueness: { scope: [:taggable_type, :taggable_id] }
end