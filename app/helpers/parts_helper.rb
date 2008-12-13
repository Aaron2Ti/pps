module PartsHelper
  def vrml(src)
    tag :embed,
      { :src => src,
        :type => 'model/vrml',
        :width => 400, 
        :height => 400,
        :consolemode => 1, 
        :skin => '{46BB95BF-8EB4-481A-A1EF-50D43FC32B9D}' }
  end

  def link_to_show(part)
    link_to((image_tag('Light.png')), part_path(part))
  end
  def link_to_edit(part)
    link_to(image_tag('Edit.png', :class => 'edit'), edit_part_path(part))
  end
  def link_to_delete(part)
    link_to (image_tag('Forbid.png')), part_path(part), :method => :delete
  end
end
