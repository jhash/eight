namespace :blog do
  desc "Generate an example blog post"
  task generate_example: :environment do
    # Find or create a user for the blog post
    user = User.first || User.create!(
      email: "admin@example.com",
      name: "Admin User"
    )

    # Create sample tags
    tags = %w[Technology Rails Ruby Programming Web Development].map do |tag_name|
      Tag.find_or_create_by!(name: tag_name) do |tag|
        tag.slug = tag_name.parameterize
      end
    end

    # Generate example blog post
    blog_post = BlogPost.create!(
      title: "Building Modern Web Applications with Rails #{Rails::VERSION::STRING}",
      content: <<~CONTENT,
        Rails continues to be one of the most productive frameworks for building modern web applications. With the release of Rails #{Rails::VERSION::STRING}, developers have access to even more powerful features that streamline development and improve performance.

        ## Key Features in Modern Rails

        ### Hotwire Integration

        Hotwire represents a paradigm shift in how we build interactive web applications. By sending HTML over the wire instead of JSON, we can create reactive user interfaces without writing much JavaScript.

        ```ruby
        class MessagesController < ApplicationController
          def create
            @message = Message.create!(message_params)
            respond_to do |format|
              format.turbo_stream
              format.html { redirect_to messages_url }
            end
          end
        end
        ```

        ### Active Record Improvements

        Active Record continues to evolve with better performance and more intuitive APIs. The new features include:

        - Improved query performance with better indexing strategies
        - Enhanced connection pooling for better concurrency
        - More flexible attribute API for custom types

        ### Action Cable Enhancements

        Real-time features have become essential in modern applications. Action Cable makes it easy to add WebSocket support to your Rails app:

        ```ruby
        class ChatChannel < ApplicationCable::Channel
          def subscribed
            stream_from "chat_\#{params[:room_id]}"
          end
        #{'  '}
          def speak(data)
            ActionCable.server.broadcast(
              "chat_\#{params[:room_id]}",
              message: data['message']
            )
          end
        end
        ```

        ## Best Practices for Rails Development

        ### 1. Keep Controllers Thin

        Controllers should only handle HTTP-specific logic. Business logic belongs in models or service objects:

        ```ruby
        class OrdersController < ApplicationController
          def create
            @order = OrderService.new(order_params).process
        #{'    '}
            if @order.persisted?
              redirect_to @order, notice: 'Order was successfully created.'
            else
              render :new
            end
          end
        end
        ```

        ### 2. Use Strong Parameters

        Always use strong parameters to protect against mass assignment vulnerabilities:

        ```ruby
        def user_params
          params.require(:user).permit(:name, :email, :password)
        end
        ```

        ### 3. Leverage Rails Conventions

        Rails is built on the principle of "Convention over Configuration". Following Rails conventions leads to:

        - More maintainable code
        - Easier onboarding for new developers
        - Better integration with gems and tools

        ## Performance Optimization

        ### Database Optimization

        - Use proper indexes on foreign keys and frequently queried columns
        - Avoid N+1 queries with includes and joins
        - Use counter caches for association counts

        ### Caching Strategies

        Rails provides multiple caching layers:

        1. **Page Caching**: For static pages
        2. **Action Caching**: For pages with simple authentication
        3. **Fragment Caching**: For partial views
        4. **Low-level Caching**: For computed values

        ```ruby
        Rails.cache.fetch("expensive_calculation_\#{id}", expires_in: 1.hour) do
          perform_expensive_calculation
        end
        ```

        ## Testing Your Rails Application

        A comprehensive test suite is crucial for maintaining code quality:

        ```ruby
        class UserTest < ActiveSupport::TestCase
          test "should not save user without email" do
            user = User.new(name: "John Doe")
            assert_not user.save, "Saved the user without an email"
          end
        end
        ```

        ## Deployment Considerations

        When deploying Rails applications to production:

        1. Use environment variables for sensitive configuration
        2. Enable SSL/TLS for all connections
        3. Set up proper logging and monitoring
        4. Configure background job processing
        5. Implement proper error tracking

        ## Conclusion

        Rails continues to be an excellent choice for building web applications in #{Date.current.year}. Its mature ecosystem, convention-based approach, and continuous improvements make it a productive framework for developers of all skill levels.

        Whether you're building a simple blog or a complex enterprise application, Rails provides the tools and patterns you need to succeed. The key is to understand and leverage Rails conventions while keeping your code clean, tested, and performant.

        Happy coding!
      CONTENT
      excerpt: "Explore the latest features and best practices for building modern web applications with Ruby on Rails. Learn about Hotwire integration, performance optimization, and deployment strategies.",
      status: :published,
      user: user,
      meta_title: "Building Modern Web Apps with Rails #{Rails::VERSION::STRING} - Complete Guide",
      meta_description: "Learn how to build modern web applications with Rails #{Rails::VERSION::STRING}. Covers Hotwire, Active Record improvements, best practices, and performance optimization.",
      meta_keywords: "Rails, Ruby on Rails, web development, Hotwire, Turbo, Stimulus, Active Record, web applications",
      reading_time_minutes: 8,
      featured_image_url: "https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=1200&h=630&fit=crop",
      featured_image_alt: "Code editor showing Ruby on Rails code",
      published_at: 1.day.ago,
      views_count: rand(100..1000)
    )

    # Add tags to the blog post
    blog_post.tags = tags.sample(3)

    puts "✅ Created example blog post: #{blog_post.title}"
    puts "   URL: /blog/#{blog_post.slug}"
    puts "   Tags: #{blog_post.tags.pluck(:name).join(', ')}"
    puts "   Author: #{blog_post.user.name}"
  end

  desc "Delete all example blog posts"
  task delete_examples: :environment do
    count = BlogPost.where("title LIKE ?", "%Building Modern Web Applications with Rails%").destroy_all.count
    puts "✅ Deleted #{count} example blog post(s)"
  end
end
