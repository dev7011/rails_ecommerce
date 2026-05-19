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

  def file_upload_field(form, attribute, options = {})
    options.reverse_merge!(
      multiple: false,
      accept: nil
    )

    file_input_class = "block w-full text-sm text-gray-700
                file:mr-4 file:rounded-md file:border-0
                file:bg-gray-100 file:px-4 file:py-2
                file:text-sm file:font-medium
                file:text-gray-700 hover:file:bg-gray-200"

    wrapper_class = "mt-2 w-full rounded-md border border-gray-200 shadow-sm px-3 py-2"

    content_tag(:div) do
      safe_join([
                  form.label(attribute),
                  content_tag(:div, class: wrapper_class) do
                    form.file_field(
                      attribute,
                      accept: options[:accept],
                      multiple: options[:multiple],
                      class: file_input_class)
                  end
                ])
    end
  end

end
