module ArchivesHelper
  def show_archive(archive)
    link_to image_tag('Part.ico', :class => 'operator'), archive_path(archive)
  end

  def edit_archive(archive)
    link_to image_tag('Assemble.ico', :class => 'operator'), 
      edit_archive_path(archive)
  end

  def del_archive(archive)
    link_to image_tag('Sldworks.ico', :class => 'operator'), 
      archive_path(archive), :method => :delete
  end
end
