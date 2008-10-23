class Assemble < Paper
  belongs_to :archive  
  has_many :parts
  has_many :parameters, :through => :parts
end
