class AddIndexToDogsEmail < ActiveRecord::Migration
  def change
          add_index :dogs, :email, unique: true
  end
end