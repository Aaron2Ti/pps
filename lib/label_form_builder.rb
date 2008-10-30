require 'action_view'

class LabelFormBuilder < ActionView::Helpers::FormBuilder
  helpers = %w(text_field text_area file_field password_field
                select check_box radio_button)

  helpers.each do |helper|
    define_method(helper) do |method, *args|
      options = args.last.is_a?(Hash) ? args.pop : {}
      options[:label] ? label(method, options.delete(:label)) + "\n" + super : super 
    end
  end
end

def labelled_form_for(record_or_name_or_array, *args, &proc)
  options = args.extract_options!
  form_for(record_or_name_or_array, 
           *(args << options.merge(:builder => LabelFormBuilder)), &proc)
end
