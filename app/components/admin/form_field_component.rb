# frozen_string_literal: true

class Admin::FormFieldComponent < ViewComponent::Base
  def initialize(form:, attribute:, model:)
    @form = form
    @attribute = attribute
    @model = model
  end

  private

  attr_reader :form, :attribute, :model

  def field_type
    column = model.class.columns_hash[attribute.to_s]
    return :association if association?
    return :boolean if column&.type == :boolean
    return :text if column&.type == :text
    return :number if [:integer, :decimal, :float].include?(column&.type)
    return :datetime if [:datetime, :timestamp].include?(column&.type)
    return :date if column&.type == :date
    :string
  end

  def association?
    attribute.to_s.end_with?("_id") && model.class.reflect_on_all_associations.any? { |a| a.foreign_key == attribute.to_s }
  end

  def label_text
    attribute.to_s.humanize
  end

  def field_classes
    "block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
  end

  def readonly?
    %w[id created_at updated_at].include?(attribute.to_s)
  end
end
