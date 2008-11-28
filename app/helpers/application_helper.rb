# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def clear
    content_tag :div,nil,:style => 'border: none; clear: both;'
  end
end
