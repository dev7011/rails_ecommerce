# frozen_string_literal: true
class Dashboard::ItemComponent < ViewComponent::Base
  def initialize(title:, value:)
    super()
    @title = title
    @value = value
  end
end
