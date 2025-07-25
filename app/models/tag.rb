class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :blog_posts, through: :taggings, source: :taggable, source_type: 'BlogPost'
  
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  
  # Callbacks
  before_validation :generate_slug, if: -> { slug.blank? && name.present? }
  
  # Scopes
  scope :popular, -> { joins(:taggings).group(:id).order('COUNT(taggings.id) DESC') }
  
  def to_param
    slug
  end
  
  private
  
  def generate_slug
    self.slug = name.parameterize
  end
end