class AddDescribeDataToPart < ActiveRecord::Migration
  def self.up
    add_column :papers, :published, :boolean, :default => false
    add_column :papers, :name, :string
    add_column :papers, :downloads, :integer, :default => 0
  end

  def self.down
    remove_column :papers, :downloads, :name, :published
  end
end
