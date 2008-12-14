class AddAvailableToPaper < ActiveRecord::Migration
  def self.up
    add_column :papers, :available, :boolean, :default => false
  end

  def self.down
    remove_column :papers, :available
  end
end
