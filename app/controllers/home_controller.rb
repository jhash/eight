class HomeController < ApplicationController
  def index
    @recent_blog_posts = BlogPost.published.order(published_at: :desc).limit(6)
  end

  def test_editor
    # This action is for testing the rich text editor
  end
end
