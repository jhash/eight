class CreateBlogPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :blog_posts do |t|
      # Basic content
      t.string :title, null: false
      t.string :slug, null: false
      t.text :content, null: false
      t.text :excerpt
      t.integer :status, default: 0, null: false # 0: draft, 1: published, 2: archived
      
      # Author information
      t.references :user, null: false, foreign_key: true
      
      # SEO fields
      t.string :meta_title
      t.text :meta_description
      t.string :meta_keywords
      t.string :canonical_url
      t.string :og_title
      t.text :og_description
      t.string :og_image_url
      t.string :twitter_card, default: 'summary_large_image'
      t.string :twitter_title
      t.text :twitter_description
      t.string :twitter_image_url
      
      # Content metadata
      t.integer :reading_time_minutes
      t.string :featured_image_url
      t.string :featured_image_alt
      t.datetime :published_at
      
      # Schema.org structured data
      t.json :structured_data, default: {}
      
      # Analytics
      t.integer :views_count, default: 0
      
      t.timestamps
    end
    
    add_index :blog_posts, :slug, unique: true
    add_index :blog_posts, :status
    add_index :blog_posts, :published_at
    add_index :blog_posts, [:status, :published_at]
  end
end
