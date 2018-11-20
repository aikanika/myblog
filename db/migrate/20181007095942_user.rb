class User < ActiveRecord::Migration[5.2]
  def change
    create_table "users", force: :cascade do |t|
      t.string "name", limit: 191, null: false
      t.string "mail", limit: 191, null: false
      t.string "password_digest", limit: 191, null: false
      t.string "remember_token", limit: 191
      t.string "image"
      t.text "introduction"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
