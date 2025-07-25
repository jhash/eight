# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  def initialize(current_user:)
    @current_user = current_user
  end

  private

  attr_reader :current_user

  def user_initials
    return "" unless current_user
    names = current_user.name.split
    if names.size >= 2
      "#{names.first[0]}#{names.last[0]}".upcase
    else
      names.first[0..1].upcase
    end
  end
end
