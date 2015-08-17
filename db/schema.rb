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

ActiveRecord::Schema.define(version: 8) do

  create_table "commands", force: :cascade do |t|
    t.string  "name"
    t.integer "tweet_id"
    t.boolean "done"
  end

  create_table "measurements", force: :cascade do |t|
    t.integer "movement_ground"
    t.integer "light"
    t.integer "temperature"
  end

  create_table "templates", primary_key: "Baustein_ID", force: :cascade do |t|
    t.string   "Baustein_Titel"
    t.string   "Baustein_Typ"
    t.integer  "Baustein_Prio"
    t.integer  "Baustein_von"
    t.integer  "Baustein_bis"
    t.datetime "Baustein_Zeitvon"
    t.datetime "Baustein_Zeitbis"
    t.integer  "Sensor_Nr"
    t.integer  "Sensor_Min"
    t.integer  "Sensor_Max"
    t.integer  "Min_vergangenseitmessung"
    t.integer  "zufallszahl_set"
    t.integer  "zufallszahl_position"
    t.text     "Baustein_Text"
    t.string   "Baustein_Vorspann"
    t.string   "Baustein_Abspann"
    t.string   "Baustein_Quelle"
    t.string   "bild_name"
    t.string   "bild_bu"
    t.string   "bild_credit"
  end

  create_table "tweets", force: :cascade do |t|
    t.string   "user"
    t.text     "text"
    t.string   "location"
    t.string   "image"
    t.boolean  "done"
    t.datetime "tweeted_at"
    t.integer  "twitter_id", limit: 8
  end

end
