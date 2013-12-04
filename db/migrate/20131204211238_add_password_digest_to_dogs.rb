class AddPasswordDigestToDogs < ActiveRecord::Migration
  def change
    add_column :dogs, :password_digest, :string
  end
end
