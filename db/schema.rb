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

ActiveRecord::Schema.define(:version => 20140206173641) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "albumable_id"
    t.string   "albumable_type"
    t.integer  "cover"
    t.string   "token"
  end

  create_table "attachables", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "gallery_id"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "token_secret"
  end

  create_table "avatars", :force => true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "avatarable_id"
    t.string   "avatarable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "chats", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"

  create_table "craps", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.float    "name"
    t.float    "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friends", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "pic"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "profile_url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "friendships", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.integer  "user_id"
    t.integer  "friend_id"
  end

  create_table "galleries", :force => true do |t|
    t.integer  "gallerable_id"
    t.string   "gallerable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.string   "group_type"
    t.string   "privacy"
    t.string   "about"
    t.integer  "membership_id"
    t.integer  "event_id"
    t.string   "headline"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "location_name"
  end

  create_table "localfeeds", :force => true do |t|
    t.string   "city"
    t.integer  "scribble_id"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "postcode"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "actor_id"
    t.string   "country"
    t.string   "country_code"
    t.string   "postal_code"
    t.string   "city"
    t.string   "political"
    t.string   "locality"
    t.string   "sublocality"
    t.string   "street_address"
    t.integer  "localfeed_id"
    t.integer  "user_id"
  end

  create_table "mailboxes", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mappedfriends", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "pic"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "profile_url"
  end

  create_table "maptest3s", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "memberships", :force => true do |t|
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "message_senders", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.datetime "read_at"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "recipient_ids"
    t.integer  "chat_id"
    t.datetime "deleted_at"
    t.datetime "sender_read_at"
    t.datetime "trashed_at"
    t.datetime "received_at"
    t.string   "ancestry"
    t.integer  "user_id"
    t.boolean  "editable",          :default => true
    t.datetime "sent_at"
    t.string   "profile_firstname"
  end

  add_index "messages", ["ancestry"], :name => "index_messages_on_ancestry"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "pictures", :force => true do |t|
    t.integer  "album_id"
    t.string   "image"
    t.string   "description"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "album_token"
  end

  create_table "places", :force => true do |t|
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "location_id"
    t.integer  "locationable_id"
    t.string   "locationable_type"
  end

  create_table "profiles", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.date     "age"
    t.string   "website"
    t.string   "phoneNo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "profile_id", :null => false
    t.string   "actor_id"
    t.string   "name"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "users_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scribbles", :force => true do |t|
    t.string   "post"
    t.string   "posted_by"
    t.integer  "promotes"
    t.integer  "demotes"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "actor_id"
    t.integer  "user_id"
    t.integer  "scribbled_id"
    t.string   "scribbled_type"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "actor_id",                               :null => false
    t.string   "profile_id"
    t.integer  "location_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  add_index "users", ["actor_id"], :name => "index_users_on_actor_id", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["profile_id"], :name => "index_users_on_profile_id", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
