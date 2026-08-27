module ApplicationHelper
  def search_component(&block)
    content_tag(:div, class: "search-component", &block)
  end
end
