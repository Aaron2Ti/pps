# CssViewHelpers

# button_link_to(name, 'button.png', options = {}, html_options = {},
def button_link_to(name, img, options = {}, html_options = {},
                    *parameters_for_method_reference)
  name = img ? image_tag(img) + name : name
  html_options['class'] = 'button positive'
  link_to(name, options = {}, html_options, *parameters_for_method_reference)
end

module ActionView::Helpers
  module FormTagHelper
    # e.g.  submit_tag('cancel', 'buttons/cancel.png')
    def submit_tag(value = 'submit', img = nil, options = {})
      content_or_options_with_block = img ? image_tag(img) + value : value
      options.stringify_keys!
        
      if disable_with = options.delete("disable_with")
        options["onclick"] = "this.disabled=true; this.value='#{disable_with}'; this.form.submit();#{options["onclick"]}"
      end
      content_tag(:button, content_or_options_with_block,
                  {"type" => "submit", "name" => "commit",
                    "value" => value}.update(options.stringify_keys))
    end

    def text_field_tag(name, value = nil, options = {})
      options[:class] ||= 'text'
      tag :input, { "type" => "text", "name" => name, "id" => name, "value" => value }.update(options.stringify_keys)
    end

  end

  module FormHelper
    def text_field(object_name, method, options = {})
      options[:class] ||= 'text'
      InstanceTag.new(object_name, method, self, nil, options.delete(:object)).to_input_field_tag("text", options)
    end
  end

  module JavaScriptHelper
    def button_link_to_function(name, img, *args, &block)
      name = img ? image_tag(img) + name : name
      html_options = args.last.is_a?(Hash) ? args.pop : {}
      html_options['class'] = 'button positive'
      function = args[0] || ''
      
      html_options.symbolize_keys!
      function = update_page(&block) if block_given?
      content_tag(
          "a", name, 
          html_options.merge({ 
            :href => html_options[:href] || "#", 
            :onclick => (html_options[:onclick] ? "#{html_options[:onclick]}; " : "") + "#{function}; return false;" 
          })
        )
    end
  end
end
