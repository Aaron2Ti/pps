require 'solidworks'
class Part < Paper
  include ModelDoc
  has_attachment :storage => :file_system,
                 :content_type => 'application/octet-stream' 
# SolidWorks Part's MimeType is 'application/presentations' or 'image/x-presentations'
# 'application/octet-stream' 

  attr_accessible :desc

  validates_format_of :filename, :with => /^.+\.SLDPRT$/i, :on => :create
  validates_presence_of :desc, :size

  validates_as_attachment

  belongs_to :archive  
  belongs_to :assemble  

  has_many :parameters, :foreign_key => 'paper_id', :dependent => :destroy

#   include ModelDoc
end
