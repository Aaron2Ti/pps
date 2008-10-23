require 'solidworks'
class Part < Paper
  include ModelDoc
  belongs_to :archive  
  belongs_to :assemble  
  has_many :parameters, :foreign_key => 'paper_id', :dependent => :destroy
end
