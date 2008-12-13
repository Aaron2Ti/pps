# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def clear
    content_tag :div,nil,
      :style => 'clear: both; border: none; background: transparent; height: 0px; width: 0px;'
  end
end
