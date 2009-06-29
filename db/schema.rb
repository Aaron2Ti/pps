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

ActiveRecord::Schema.define(:version => 14) do

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
    t.boolean "available",    :default => false
    t.boolean "published",    :default => false
    t.string  "name"
    t.integer "downloads",    :default => 0
    t.integer "owner_id"
  end

  create_table "parameters", :force => true do |t|
    t.integer "paper_id"
    t.string  "name"
    t.string  "desc"
    t.float   "value",    :default => 10.0
    t.string  "def"
  end

  create_table "suppliers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string  "taggable_type"
    t.integer "owner_id"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type"], :name => "index_taggings_on_tag_id_and_taggable_id_and_taggable_type", :unique => true
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login",             :null => false
    t.string   "crypted_password",  :null => false
    t.string   "password_salt",     :null => false
    t.string   "persistence_token", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "email"
    t.string   "title"
    t.string   "company"
    t.string   "avatar"
    t.string   "type"
    t.string   "primary_cad"
    t.string   "company_name"
    t.string   "nation"
    t.string   "province"
    t.string   "city"
    t.string   "address"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "fax"
    t.string   "website"
  end

end
