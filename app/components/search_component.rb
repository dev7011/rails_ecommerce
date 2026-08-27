# frozen_string_literal: true

class SearchComponent < ViewComponent::Base

  def initialize(path:)
    super()
    @path = path
  end

end
