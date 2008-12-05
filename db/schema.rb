ActiveRecord::Schema.define(:version => 4) do

  create_table "archives", :force => true do |t|
    t.string  "desc"
    t.string  "filename"
    t.string  "content_type"
    t.integer "size"
  end

  create_table "papers", :force => true do |t|
    t.integer "archive_id"
    t.integer "assemble_id"
    t.string  "filename"
    t.string  "desc"
    t.string  "type"
    t.integer "size"
    t.string  "content_type"
    t.string  "thumb"
  end

  create_table "parameters", :force => true do |t|
    t.integer "paper_id"
    t.string  "name"
    t.string  "desc"
    t.float   "default",  :default => 10.0
  end

end
