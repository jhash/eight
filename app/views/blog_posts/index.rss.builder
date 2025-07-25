xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title t('blog_posts.rss.title', default: 'Blog - Eight')
    xml.description t('blog_posts.rss.description', default: 'Latest blog posts from Eight')
    xml.link blog_posts_url
    xml.language I18n.locale.to_s

    @blog_posts.each do |blog_post|
      xml.item do
        xml.title blog_post.title
        xml.description blog_post.excerpt || blog_post.content.to_s.gsub(/<[^>]*>/, '').truncate(300)
        xml.pubDate blog_post.published_at.to_s(:rfc822)
        xml.link blog_post_url(blog_post)
        xml.guid blog_post_url(blog_post)
        
        blog_post.tags.each do |tag|
          xml.category tag.name
        end
        
        xml.author "#{blog_post.user.email} (#{blog_post.user.name})"
      end
    end
  end
end