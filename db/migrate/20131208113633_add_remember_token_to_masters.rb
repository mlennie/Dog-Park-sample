class AddRememberTokenToMasters < ActiveRecord::Migration
  def change
  	add_column :masters, :remember_token, :string
  	add_index  :masters, :remember_token
  end
end
