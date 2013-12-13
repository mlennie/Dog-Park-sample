class AddAdminToMasters < ActiveRecord::Migration
  def change
    add_column :masters, :admin, :boolean, default: false
  end
end
