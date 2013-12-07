class AddIndexToMastersEmail < ActiveRecord::Migration
  def change
  	add_index :masters, :email, unique: true
  end
end
