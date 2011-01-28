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

ActiveRecord::Schema.define(:version => 20110128131933) do

  create_table "nzones", :force => true do |t|
    t.integer  "task_id"
    t.decimal  "l"
    t.decimal  "nSize"
    t.decimal  "ro"
    t.decimal  "ti"
    t.decimal  "te"
    t.decimal  "v"
    t.decimal  "exp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nzones", ["task_id"], :name => "index_nzones_on_task_id"

  create_table "pzones", :force => true do |t|
    t.integer  "task_id"
    t.string   "l"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.string   "exp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "HydroStage"
    t.boolean  "HeatStage"
    t.boolean  "ExchangeStage"
    t.string   "source"
    t.decimal  "tauPulse"
    t.decimal  "fluence"
    t.decimal  "deltaSkin"
    t.decimal  "courant"
    t.decimal  "maxTime"
    t.integer  "user_id"
    t.string   "status"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
