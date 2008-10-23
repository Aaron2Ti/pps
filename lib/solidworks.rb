# Do some view modify in linux disable 'win32ole'
require 'win32ole'
require 'ftools'
require 'encoding_filter'

def solidworks
	begin
		@sldworks = WIN32OLE.connect('SldWorks.Application')
	rescue WIN32OLERuntimeError
		@sldworks = WIN32OLE.new('SldWorks.Application')
	end
  @sldworks.visible = true
	@sldworks.extend SldWorks
end

module SldWorks
	def open_doc(paper)
    filetype = (paper.filename.upcase =~ /.SLDPRT$/) ? 1 : 2
    filename = utf8_to_gbk(paper.absolute_filename)
    self.OpenDoc(filename, filetype)
		self.ActiveDoc().extend ModelDoc
	end
	def exit
		self.ExitApp()
	end
end

module ModelDoc
	def save_as(paper)
    rebuild
    filename = utf8_to_gbk(paper.absolute_vrml_filename)
		self.SaveAs(filename)
	end
  def rebuild
		self.EditRebuild3
    self.ViewZoomtofit2
  end
	def	save_doc
    rebuild
    self.Save2 false
	end
	def set_value(parameter, value = 10.0)
		self.Parameter(parameter).SystemValue = value/1000.0
	end
	def close_doc(filename)
    self.CloseDoc filename
	end
  # up is the default solidworks's api
end
