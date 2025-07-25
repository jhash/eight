class HomeController < ApplicationController
  def index
    @recent_blog_posts = BlogPost.published.recent.includes(:user, :tags).limit(3)
  end
end
