class AddThumbToPapers < ActiveRecord::Migration
  def self.up
    add_column :papers, :thumb, :string 
  end

  def self.down
    remove_column :papers, :thumb
  end
end
