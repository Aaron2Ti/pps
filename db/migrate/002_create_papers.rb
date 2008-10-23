class CreatePapers < ActiveRecord::Migration
  def self.up
    create_table :papers do |t|
      t.column "archive_id", :integer
      t.column "filename", :string
      t.column "desc", :string
      t.column "type", :string
      t.column "assemble_id", :integer
    end
  end

  def self.down
    drop_table :papers
  end
end
