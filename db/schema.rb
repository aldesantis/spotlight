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

ActiveRecord::Schema.define(version: 20171128233929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "repo_provider", null: false
    t.string "repo_uri", null: false
    t.string "encrypted_oauth_access_token", null: false
    t.string "encrypted_oauth_access_token_iv", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "webhook_id"
    t.datetime "set_up_at"
    t.index ["name"], name: "index_projects_on_name"
    t.index ["repo_provider", "repo_uri"], name: "index_projects_on_repo_provider_and_repo_uri"
  end

end
