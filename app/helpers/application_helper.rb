# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # button_link_to(name, 'button.png', options = {}, html_options = {},
  def button_link_to(name, img, options = {}, html_options = {},
                      *parameters_for_method_reference)
    name = img ? image_tag(img) + name : name
    html_options['class'] = 'button positive'
    link_to(name, options = {}, html_options, *parameters_for_method_reference)
  end

  def edit_desc(obj)
    unless obj.desc.blank?
      edit = obj.desc
    else
      edit = 'edit'
    end
  end

  def file_icon(filename ='')
    image_tag case File.extname(filename).upcase
      when '.ZIP' then '/images/Sldworks.ico'
      when '.SLDPRT' then 'Part.ico'
#       when '.SLDASM' then 'Assemble.ico'
      when '.SLDASM' then '/images/Assemble.ico'
      else 'Sldworks.ico'
      end
  end

  def paper_icon(paper)
    image_tag case File.extname(paper.filename).upcase
      when '.ZIP' then '/images/Sldworks.ico'
      when '.SLDPRT' then '/images/Part.ico'
      when '.SLDASM' then '/images/Assemble.ico'
      else '/images/Sldworks.ico'
    end
  end
end
