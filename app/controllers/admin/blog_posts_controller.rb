class Admin::BlogPostsController < ApplicationController
  before_action :require_superadmin
  before_action :set_blog_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @blog_posts = BlogPost.includes(:user, :tags)
    @blog_posts = @blog_posts.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    @blog_posts = @blog_posts.where("content LIKE ?", "%#{params[:content]}%") if params[:content].present?
    @blog_posts = @blog_posts.order(created_at: :desc).page(params[:page])
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def edit
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    @blog_post.user = current_user

    if @blog_post.save
      redirect_to admin_blog_post_path(@blog_post), notice: "Blog post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to admin_blog_post_path(@blog_post), notice: "Blog post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to admin_blog_posts_path, notice: "Blog post was successfully destroyed."
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find_by!(slug: params[:id])
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :status, :excerpt, :featured_image_url,
                                      :published_at, :tag_list, :meta_title, :meta_description,
                                      :og_title, :og_description, :twitter_title, :twitter_description,
                                      :featured_image, content_images: [])
  end

  def require_superadmin
    redirect_to root_path, alert: "Not authorized" unless current_user&.superadmin?
  end
end
