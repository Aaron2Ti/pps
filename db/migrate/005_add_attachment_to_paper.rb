class AddAttachmentToPaper < ActiveRecord::Migration
  def self.up
    add_column :papers, :size, :integer
    add_column :papers, :content_type, :string
  end

  def self.down
    remove_column :papers, :content_type, :filename
  end
end
