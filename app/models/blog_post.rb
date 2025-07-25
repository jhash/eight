class BlogPost < ApplicationRecord
  belongs_to :user
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  
  # Status enum
  enum :status, { draft: 0, published: 1, archived: 2 }
  
  # Validations
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :content, presence: true
  
  # Scopes
  scope :published, -> { where(status: :published).where('published_at <= ?', Time.current) }
  scope :recent, -> { order(published_at: :desc) }
  scope :featured, -> { where.not(featured_image_url: nil) }
  
  # Callbacks
  before_validation :generate_slug, if: -> { slug.blank? && title.present? }
  before_validation :set_published_at, if: -> { status_changed? && published? }
  before_save :calculate_reading_time
  before_save :set_seo_defaults
  
  # Instance methods
  def to_param
    slug
  end
  
  def published?
    status == 'published' && published_at.present? && published_at <= Time.current
  end
  
  def increment_views!
    increment!(:views_count)
  end
  
  def tag_list
    tags.pluck(:name).join(', ')
  end
  
  def tag_list=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
  
  private
  
  def generate_slug
    self.slug = title.parameterize
    # Ensure uniqueness
    if BlogPost.where.not(id: id).exists?(slug: slug)
      self.slug = "#{slug}-#{SecureRandom.hex(4)}"
    end
  end
  
  def set_published_at
    self.published_at ||= Time.current if published?
  end
  
  def calculate_reading_time
    return unless content.present?
    word_count = content.split.size
    self.reading_time_minutes = (word_count / 200.0).ceil # Average reading speed: 200 words/minute
  end
  
  def set_seo_defaults
    self.meta_title ||= title
    self.meta_description ||= excerpt || content.truncate(160)
    self.og_title ||= meta_title
    self.og_description ||= meta_description
    self.twitter_title ||= meta_title
    self.twitter_description ||= meta_description
  end
end