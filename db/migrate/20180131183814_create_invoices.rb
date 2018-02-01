class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.string :order_id, index: true
      t.string :patient_id, index: true
      t.string :state
      t.timestamps
    end
  end
end
