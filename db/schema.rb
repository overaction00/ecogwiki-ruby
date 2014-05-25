# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140525111315) do

  create_table "inverted_indices", :force => true do |t|
    t.string   "word"
    t.string   "page"
    t.integer  "count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "inverted_indices", ["page"], :name => "index_inverted_indices_on_page"
  add_index "inverted_indices", ["word"], :name => "index_inverted_indices_on_word"

  create_table "old_wikipages", :force => true do |t|
    t.string   "title"
    t.string   "body"
    t.integer  "revision"
    t.integer  "user_id"
    t.string   "comment"
    t.string   "modifier"
    t.integer  "wikipage_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "old_wikipages", ["modifier"], :name => "index_old_wikipages_on_modifier"
  add_index "old_wikipages", ["title"], :name => "index_old_wikipages_on_title"
  add_index "old_wikipages", ["user_id"], :name => "index_old_wikipages_on_user_id"

  create_table "preferences", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "preferences", ["email"], :name => "index_preferences_on_email"
  add_index "preferences", ["title"], :name => "index_preferences_on_title"
  add_index "preferences", ["user_id"], :name => "index_preferences_on_user_id"

  create_table "similar_pages", :force => true do |t|
    t.integer  "wikipage_id"
    t.string   "title"
    t.float    "score"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "similar_pages", ["title"], :name => "index_similar_pages_on_title"
  add_index "similar_pages", ["wikipage_id"], :name => "index_similar_pages_on_wikipage_id"

  create_table "social_auths", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "social_id"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "social_auths", ["email"], :name => "index_social_auths_on_email"
  add_index "social_auths", ["social_id"], :name => "index_social_auths_on_social_id"
  add_index "social_auths", ["user_id"], :name => "index_social_auths_on_user_id"

  create_table "tocs", :force => true do |t|
    t.integer  "wikipage_id"
    t.string   "key"
    t.string   "title"
    t.integer  "depth"
    t.integer  "order"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tocs", ["title"], :name => "index_tocs_on_title"
  add_index "tocs", ["wikipage_id"], :name => "index_tocs_on_wikipage_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["id"], :name => "index_users_on_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wikipages", :force => true do |t|
    t.string   "title"
    t.string   "body"
    t.integer  "revision"
    t.string   "comment"
    t.integer  "user_id"
    t.string   "modifier"
    t.string   "acl_read"
    t.string   "acl_write"
    t.integer  "link_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "wikipages", ["modifier"], :name => "index_wikipages_on_modifier"
  add_index "wikipages", ["title"], :name => "index_wikipages_on_title"
  add_index "wikipages", ["user_id"], :name => "index_wikipages_on_user_id"

end
