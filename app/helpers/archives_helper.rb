module ArchivesHelper
  def show_paper(paper)
    link_to image_tag('Part.ico', :class => 'operator'),
      polymorphic_path(paper)
  end

  def edit_paper(paper)
    link_to image_tag('Assemble.ico', :class => 'operator'), 
      edit_polymorphic_path(paper)
  end

  def del_paper(paper)
    link_to image_tag('Sldworks.ico', :class => 'operator'), 
      polymorphic_path(paper), :method => :delete
  end
end
