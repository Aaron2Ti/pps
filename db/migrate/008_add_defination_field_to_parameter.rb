class AddDefinationFieldToParameter < ActiveRecord::Migration
  def self.up
    add_column :parameters, :def, :string
  end

  def self.down
  end
end
