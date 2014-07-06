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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140629172159) do

  create_table "actors", force: true do |t|
    t.string   "name"
    t.string   "about"
    t.string   "location"
    t.string   "avatar"
    t.string   "style"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actors_movies", force: true do |t|
    t.integer "movie_id"
    t.integer "actor_id"
  end

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "author"
    t.string   "thumb"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.integer  "user_id"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_image_galleries", force: true do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: true do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "province_id"
    t.integer  "level"
    t.string   "zip_code"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["level"], name: "index_cities_on_level", using: :btree
  add_index "cities", ["name"], name: "index_cities_on_name", using: :btree
  add_index "cities", ["pinyin"], name: "index_cities_on_pinyin", using: :btree
  add_index "cities", ["pinyin_abbr"], name: "index_cities_on_pinyin_abbr", using: :btree
  add_index "cities", ["province_id"], name: "index_cities_on_province_id", using: :btree
  add_index "cities", ["zip_code"], name: "index_cities_on_zip_code", using: :btree

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "directors", force: true do |t|
    t.string   "name"
    t.string   "about"
    t.string   "location"
    t.string   "avatar"
    t.string   "style"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "districts", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "districts", ["city_id"], name: "index_districts_on_city_id", using: :btree
  add_index "districts", ["name"], name: "index_districts_on_name", using: :btree
  add_index "districts", ["pinyin"], name: "index_districts_on_pinyin", using: :btree
  add_index "districts", ["pinyin_abbr"], name: "index_districts_on_pinyin_abbr", using: :btree

  create_table "events", force: true do |t|
    t.string   "thumb"
    t.string   "address"
    t.text     "content"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "title"
    t.text     "summary"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "home_page",       default: false
    t.integer  "home_page_order", default: 0
  end

  create_table "follows", force: true do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.text     "content"
    t.boolean  "is_read",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["from_id"], name: "index_messages_on_from_id", using: :btree
  add_index "messages", ["to_id"], name: "index_messages_on_to_id", using: :btree

  create_table "movies", force: true do |t|
    t.string   "title"
    t.text     "desc"
    t.string   "short_desc"
    t.string   "thumb"
    t.string   "duration"
    t.string   "url"
    t.text     "summary"
    t.integer  "director_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "home_page",       default: false
    t.integer  "home_page_order", default: 0
  end

  create_table "partners", force: true do |t|
    t.string   "name"
    t.string   "thumb"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.string   "nickname"
    t.string   "gender"
    t.string   "about"
    t.string   "province"
    t.string   "city"
    t.string   "district"
    t.string   "location"
    t.string   "name"
    t.string   "role"
    t.string   "style"
    t.string   "avatar"
    t.integer  "profilable_id"
    t.string   "profilable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["profilable_id"], name: "index_profiles_on_profilable_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "title",           default: "untitled"
    t.string   "province"
    t.string   "city"
    t.string   "district"
    t.string   "location"
    t.string   "contact"
    t.string   "duration"
    t.string   "budget"
    t.text     "description"
    t.text     "script"
    t.text     "team"
    t.text     "plan"
    t.text     "expense"
    t.string   "cover"
    t.string   "video"
    t.integer  "user_id"
    t.string   "status",          default: "draft"
    t.datetime "start_at"
    t.integer  "project_id"
    t.string   "movie_type"
    t.datetime "published_at"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "home_page",       default: false
    t.integer  "home_page_order", default: 0
  end

  create_table "promotion_records", force: true do |t|
    t.datetime "promote_time"
    t.string   "channel"
    t.string   "desc"
    t.string   "screenshot"
    t.string   "url"
    t.integer  "promotion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promotions", force: true do |t|
    t.string   "title",         default: "untitled"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "state",         default: "draft"
    t.string   "cover"
    t.string   "reject_reason"
  end

  create_table "provinces", force: true do |t|
    t.string   "name"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provinces", ["name"], name: "index_provinces_on_name", using: :btree
  add_index "provinces", ["pinyin"], name: "index_provinces_on_pinyin", using: :btree
  add_index "provinces", ["pinyin_abbr"], name: "index_provinces_on_pinyin_abbr", using: :btree

  create_table "site_configs", force: true do |t|
    t.string   "property"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.string  "context",        default: "default"
  end

  add_index "tags", ["context"], name: "index_tags_on_context", using: :btree

  create_table "tickets", force: true do |t|
    t.string   "title"
    t.string   "province"
    t.string   "city"
    t.string   "district"
    t.string   "location"
    t.string   "contact"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "nickname"
    t.string   "gender"
    t.string   "about"
    t.string   "province"
    t.string   "city"
    t.string   "district"
    t.string   "location"
    t.string   "avatar"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
