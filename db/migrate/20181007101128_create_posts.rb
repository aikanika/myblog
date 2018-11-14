class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :tags
      t.text :body
      t.references :category, foreign_key: true
      t.integer :published, default:0

      t.timestamps
    end
  end
end
