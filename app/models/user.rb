class User < ActiveRecord::Base
  acts_as_authentic
  attr_protected :login
  has_many :parts,    :foreign_key => :owner_id
  has_many :papers,   :foreign_key => :owner_id
  has_many :taggings, :foreign_key => :owner_id

  def tags
    taggings.map(&:tag)
  end
end
