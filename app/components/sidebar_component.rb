# frozen_string_literal: true

class SidebarComponent < ViewComponent::Base
  def initialize(current_user:, current_path:, sidebar_filters: nil)
    @current_user = current_user
    @current_path = current_path
    @sidebar_filters = sidebar_filters
  end

  private

  attr_reader :current_user, :current_path, :sidebar_filters

  def nav_items
    items = []
    items << { name: "Home", path: root_path, icon: "home" }
    items << { name: "Blog", path: blog_posts_path, icon: "document-text" }

    if current_user
      if current_user.superadmin?
        items << {
          name: "Admin",
          icon: "cog",
          children: [
            { name: "Users", path: admin_users_path },
            { name: "Roles", path: admin_roles_path },
            { name: "Blog Posts", path: admin_blog_posts_path }
          ]
        }
      end
    end

    items
  end

  def is_active?(path)
    return false if path.nil?
    current_path == path || (path != root_path && current_path.start_with?(path))
  end

  def any_child_active?(children)
    children.any? { |child| is_active?(child[:path]) }
  end

  def item_classes(item)
    base = "flex items-center px-3 py-2 text-sm font-medium rounded-md transition-colors"
    if is_active?(item[:path])
      "#{base} bg-purple-900 dark:bg-purple-800 text-white"
    else
      "#{base} text-purple-100 hover:bg-purple-700 dark:hover:bg-purple-800 hover:text-white"
    end
  end

  def icon_svg(icon_name)
    case icon_name
    when "home"
      '<svg class="mr-3 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
      </svg>'
    when "document-text"
      '<svg class="mr-3 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
      </svg>'
    when "cog"
      '<svg class="mr-3 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
      </svg>'
    else
      ""
    end
  end
end
