class CreateParameters < ActiveRecord::Migration
  def self.up
    create_table :parameters do |t|
      t.integer 'paper_id'
      t.string 'name', 'desc'
      t.float 'default', :default => 10.0
    end
  end

  def self.down
    drop_table :parameters
  end
end
