class RemoveContentFromBlogPosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :blog_posts, :content, :text
  end
end
