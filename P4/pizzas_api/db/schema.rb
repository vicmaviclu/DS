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

ActiveRecord::Schema[7.1].define(version: 2024_05_19_115448) do
  create_table "pedidos", force: :cascade do |t|
    t.string "numero_telefono"
    t.string "direccion"
    t.string "tarjeta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "usuario"
  end

  create_table "pizzas", force: :cascade do |t|
    t.string "nombre"
    t.string "tamano"
    t.decimal "coste"
    t.integer "pedido_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pedido_id"], name: "index_pizzas_on_pedido_id"
  end

  add_foreign_key "pizzas", "pedidos"
end
