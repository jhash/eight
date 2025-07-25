atom_feed do |feed|
  feed.title t('blog_posts.atom.title', default: 'Blog - Eight')
  feed.updated @blog_posts.maximum(:updated_at) || Time.current

  @blog_posts.each do |blog_post|
    feed.entry blog_post, published: blog_post.published_at do |entry|
      entry.title blog_post.title
      entry.content blog_post.content, type: 'html'
      
      entry.author do |author|
        author.name blog_post.user.name
        author.email blog_post.user.email
      end
      
      blog_post.tags.each do |tag|
        entry.category term: tag.slug, label: tag.name
      end
    end
  end
end