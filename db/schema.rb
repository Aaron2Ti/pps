# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 3) do

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
  end

  create_table "parameters", :force => true do |t|
    t.integer "paper_id"
    t.string  "name"
    t.string  "desc"
    t.float   "default",  :default => 10.0
  end

end