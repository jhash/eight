# frozen_string_literal: true

class Admin::SidebarComponent < ViewComponent::Base
  def initialize(current_path:)
    @current_path = current_path
  end

  private

  attr_reader :current_path

  def nav_link_classes(path)
    base_classes = "flex items-center px-6 py-3 text-sm font-medium transition-colors hover:bg-gray-100"
    active_classes = "bg-gray-100 text-gray-900 border-r-2 border-gray-900"
    inactive_classes = "text-gray-600"

    is_active = current_path.start_with?(path)
    "#{base_classes} #{is_active ? active_classes : inactive_classes}"
  end

  def models
    [
      { name: "Users", path: admin_users_path },
      { name: "Roles", path: admin_roles_path }
    ]
  end
end
