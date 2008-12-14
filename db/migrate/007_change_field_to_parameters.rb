class ChangeFieldToParameters < ActiveRecord::Migration
  def self.up
    rename_column :parameters, :default, :value 
  end

  def self.down
    rename_column :parameters, :value , :default
  end
end
