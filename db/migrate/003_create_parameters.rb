class CreateParameters < ActiveRecord::Migration
  def self.up
    create_table :parameters do |t|
      t.column "paper_id", :integer
      t.column "name", :string
      t.column "desc", :string
      t.column "default", :float, :default => 10.0
    end
  end

  def self.down
    drop_table :parameters
  end
end
