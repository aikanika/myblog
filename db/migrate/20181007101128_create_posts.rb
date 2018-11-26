class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.json :image
      t.references :category, foreign_key: true
      t.integer :published, default:0

      t.timestamps
    end
  end
end
