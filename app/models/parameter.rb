class Parameter < ActiveRecord::Base
  belongs_to :paper
  belongs_to :part, :foreign_key => :paper_id
end
