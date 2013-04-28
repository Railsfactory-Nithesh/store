class AddToOrders < ActiveRecord::Migration
  def up
	  add_column :orders, :email_id, :string
  end

  def down
	  remove_column :orders, :email_id
  end
end
