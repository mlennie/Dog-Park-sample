class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :master_id

      t.timestamps
    end
    add_index :posts, [:master_id, :created_at]
  end
end
