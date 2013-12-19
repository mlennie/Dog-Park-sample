class DropDogs < ActiveRecord::Migration
  def change
          drop_table :dogs
  end
end