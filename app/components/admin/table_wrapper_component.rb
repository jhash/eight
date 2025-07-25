# frozen_string_literal: true

module Admin
  class TableWrapperComponent < ViewComponent::Base
    renders_one :header
    renders_one :table
    renders_one :pagination

    def initialize(show_pagination: true)
      @show_pagination = show_pagination
    end

    private

    attr_reader :show_pagination
  end
end