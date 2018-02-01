class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients, primary_key: 'patient_id', id: :string do |t|
      t.string :patient_name
      t.string :state

      t.timestamps
    end
  end 
end
