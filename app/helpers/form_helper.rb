module FormHelper
  def nav_item(url, options = {})
    options.reverse_merge!(icon_style: "fa-solid")


    icon_style, icon_name, label, css_class, data = options.values_at(
      :icon_style,
      :icon_name,
      :label,
      :css_class,
      :data
    )

    css_class ||= "block px-4 py-2 hover:rounded hover:bg-gray-700"

    content_tag(:li) do
      link_to url, class: css_class, data: data do
        safe_join([
                    icon(icon_style, icon_name, class: "mr-2"),
                    content_tag(:span, label, class: "hidden md:inline-block")
                  ], " ")
      end
    end
  end
end
