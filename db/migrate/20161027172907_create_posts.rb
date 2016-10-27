class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :photo
      t.text :description
      t.integer :user_id
      t.timestamps null: false
    end
  end
  add_index :posts, :user_id
end