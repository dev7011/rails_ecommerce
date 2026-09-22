# frozen_string_literal: true

require "test_helper"

class SearchComponentTest < ViewComponent::TestCase
  def test_component_renders_search_form
    render_inline(SearchComponent.new(path: products_path))

    assert_selector "form[action='#{products_path}'][method='get']"
  end
end