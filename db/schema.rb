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

ActiveRecord::Schema.define(version: 20171203075752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amenity_lists", force: :cascade do |t|
    t.boolean "wifi"
    t.integer "user_id"
    t.boolean "coffee"
    t.boolean "computer_desk"
    t.boolean "printer"
    t.boolean "projector"
    t.boolean "microwave"
    t.boolean "kitchen_access"
    t.boolean "tv_screen"
    t.boolean "outdoor_space"
    t.boolean "piano"
    t.boolean "art_space"
    t.boolean "garage"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "is_delivered",               default: false
    t.string   "delivery_method"
    t.string   "message_id"
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string  "email"
    t.string  "password"
    t.string  "billing_street_address"
    t.string  "billing_city"
    t.string  "billing_state"
    t.string  "billing_zip_code"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "credit_card_number"
    t.string  "expiration_date"
    t.string  "cvv"
    t.string  "password_digest"
    t.text    "personal_description"
    t.string  "home_street_address"
    t.string  "home_city"
    t.string  "home_state"
    t.string  "home_zip_code"
    t.text    "house_description"
    t.boolean "searchable"
    t.string  "billing_first_name"
    t.string  "billing_last_name"
    t.string  "price"
    t.string  "profile_picture"
    t.string  "house_picture"
    t.string  "house_images",             default: [], array: true
    t.string  "available_time_start"
    t.float   "latitude"
    t.float   "longitude"
    t.integer "amenity_list_id"
    t.string  "title"
    t.integer "capacity"
    t.string  "available_time_end"
    t.string  "cloud_profile_picture"
    t.string  "cloud_profile_picture_id"
    t.string  "cloud_house_picture"
    t.string  "cloud_house_picture_id"
    t.string  "cloud_house_image_ids",    default: [], array: true
  end

  add_foreign_key "amenity_lists", "users", on_delete: :cascade
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "users", "amenity_lists", on_delete: :cascade
end
