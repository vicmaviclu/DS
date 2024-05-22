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

ActiveRecord::Schema[7.1].define(version: 2024_05_21_105357) do
  create_table "ingrediente_extras", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredientes", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredientes_adicionales", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredientes_extras", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pedidos", force: :cascade do |t|
    t.string "numero_telefono"
    t.string "direccion"
    t.string "tarjeta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "usuario"
    t.decimal "costeTotal"
  end

  create_table "pizza_ingrediente_extras", force: :cascade do |t|
    t.integer "pizza_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre"
    t.index ["pizza_id"], name: "index_pizza_ingrediente_extras_on_pizza_id"
  end

  create_table "pizza_ingredientes", force: :cascade do |t|
    t.integer "pizza_id", null: false
    t.integer "ingrediente_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingrediente_id"], name: "index_pizza_ingredientes_on_ingrediente_id"
    t.index ["pizza_id"], name: "index_pizza_ingredientes_on_pizza_id"
  end

  create_table "pizza_ingredientes_extra", force: :cascade do |t|
    t.integer "pizza_id", null: false
    t.string "ingrediente", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre"
    t.index ["pizza_id"], name: "index_pizza_ingredientes_extra_on_pizza_id"
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

  add_foreign_key "pizza_ingrediente_extras", "pizzas"
  add_foreign_key "pizza_ingredientes", "ingredientes"
  add_foreign_key "pizza_ingredientes", "pizzas"
  add_foreign_key "pizza_ingredientes_extra", "pizzas"
  add_foreign_key "pizzas", "pedidos"
end
