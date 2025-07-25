# frozen_string_literal: true

class Admin::ModelTableComponent < ViewComponent::Base
  def initialize(models:, model_class:, actions: true)
    @models = models
    @model_class = model_class
    @actions = actions
  end

  private

  attr_reader :models, :model_class, :actions

  def attributes
    @attributes ||= model_class.column_names - %w[created_at updated_at]
  end

  def display_value(model, attribute)
    value = model.send(attribute)

    case value
    when ActiveSupport::TimeWithZone
      value.strftime("%Y-%m-%d %H:%M")
    when Date
      value.strftime("%Y-%m-%d")
    when TrueClass
      content_tag(:span, "Yes", class: "px-2 py-1 text-xs font-medium bg-green-100 text-green-800 rounded-full")
    when FalseClass
      content_tag(:span, "No", class: "px-2 py-1 text-xs font-medium bg-gray-100 text-gray-800 rounded-full")
    when NilClass
      content_tag(:span, "—", class: "text-gray-400")
    else
      value.to_s.truncate(50)
    end
  end

  def model_path(model)
    send("admin_#{model.class.name.underscore}_path", model)
  end

  def edit_model_path(model)
    send("edit_admin_#{model.class.name.underscore}_path", model)
  end

  def model_name
    model_class.name.pluralize
  end
end
