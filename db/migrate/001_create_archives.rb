class CreateArchives < ActiveRecord::Migration
  def self.up
    create_table :archives do |t|
      t.column "desc", :string
      t.column "filename", :string
      t.column "size", :integer
      t.column "content_type", :string
    end
  end

  def self.down
    drop_table :archives
  end
end
