# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_25_212815) do
  create_table "blog_posts", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.text "content", null: false
    t.text "excerpt"
    t.integer "status", default: 0, null: false
    t.integer "user_id", null: false
    t.string "meta_title"
    t.text "meta_description"
    t.string "meta_keywords"
    t.string "canonical_url"
    t.string "og_title"
    t.text "og_description"
    t.string "og_image_url"
    t.string "twitter_card", default: "summary_large_image"
    t.string "twitter_title"
    t.text "twitter_description"
    t.string "twitter_image_url"
    t.integer "reading_time_minutes"
    t.string "featured_image_url"
    t.string "featured_image_alt"
    t.datetime "published_at"
    t.json "structured_data", default: {}
    t.integer "views_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "published_at" ], name: "index_blog_posts_on_published_at"
    t.index [ "slug" ], name: "index_blog_posts_on_slug", unique: true
    t.index [ "status", "published_at" ], name: "index_blog_posts_on_status_and_published_at"
    t.index [ "status" ], name: "index_blog_posts_on_status"
    t.index [ "user_id" ], name: "index_blog_posts_on_user_id"
  end

  create_table "identities", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "provider", "uid" ], name: "index_identities_on_provider_and_uid", unique: true
    t.index [ "user_id" ], name: "index_identities_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "name" ], name: "index_roles_on_name", unique: true
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.string "taggable_type", null: false
    t.integer "taggable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "tag_id", "taggable_id", "taggable_type" ], name: "index_taggings_uniqueness", unique: true
    t.index [ "tag_id" ], name: "index_taggings_on_tag_id"
    t.index [ "taggable_type", "taggable_id" ], name: "index_taggings_on_taggable"
    t.index [ "taggable_type", "taggable_id" ], name: "index_taggings_on_taggable_type_and_taggable_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "name" ], name: "index_tags_on_name", unique: true
    t.index [ "slug" ], name: "index_tags_on_slug", unique: true
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "role_id" ], name: "index_user_roles_on_role_id"
    t.index [ "user_id", "role_id" ], name: "index_user_roles_on_user_id_and_role_id", unique: true
    t.index [ "user_id" ], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "email" ], name: "index_users_on_email", unique: true
  end

  add_foreign_key "blog_posts", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "taggings", "tags"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
