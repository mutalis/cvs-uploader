class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders, primary_key: 'order_id', id: :string do |t|
      t.string :category
      t.string :state

      t.timestamps
    end
  end
end
