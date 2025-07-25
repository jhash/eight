class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [ :show ]

  def index
    @blog_posts = if logged_in? && current_user.superadmin?
      BlogPost.recent.includes(:user, :tags)
    else
      BlogPost.published.recent.includes(:user, :tags)
    end

    # Simple pagination without kaminari
    page = (params[:page] || 1).to_i
    per_page = 9
    @blog_posts = @blog_posts.limit(per_page).offset((page - 1) * per_page)

    respond_to do |format|
      format.html
      format.rss { render layout: false }
      format.atom { render layout: false }
    end
  end

  def show
    puts "blog_post.published?: #{@blog_post.published?}"
    unless @blog_post.published? || (logged_in? && (current_user == @blog_post.user || current_user.superadmin?))
      redirect_to blog_posts_path, alert: t("blog_posts.not_found")
      return
    end

    @blog_post.increment_views! if @blog_post.published?
  end

  private

  def set_blog_post
    @blog_post = BlogPost.includes(:user, :tags).find_by!(slug: params[:id])
  end
end
