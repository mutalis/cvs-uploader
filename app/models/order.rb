class Order < ApplicationRecord
  self.primary_key = 'order_id'
  has_many :invoices, -> { where state: 'active' }
  has_many :patients, -> { where(state: 'active') }, through: :invoices

  scope :active, -> { where(state: 'active') }

  def self.process(uploaded_io)
    begin
      filename = Rails.root.join('public', uploaded_io.original_filename)
      File.open(filename, 'w') do |file|
        file.write(uploaded_io.read)
      end
      import(filename)
    rescue => exception
      puts exception
      return false
    end
  end

  def self.import(filename)
    data = SmarterCSV.process(filename)
    success = true

    if data.first.keys.include?(:patient_name)

      data.each do |entry|
        current = Patient.find_or_create_by(patient_id: entry[:patient_id])
        current.patient_name = entry[:patient_name]
        current.state = entry[:state]
        current.save(validate: false)
      end

    elsif data.first.keys.include?(:category)

      data.each do |entry|
        current = Order.find_or_create_by(order_id: entry[:order_id])
        current.category = entry[:category]
        current.state = entry[:state]
        current.save(validate: false)
      end

    elsif data.first.keys.include?(:patient_id) && data.first.keys.include?(:order_id)

      data.each do |entry|
        current = Invoice.where({patient_id: entry[:patient_id], order_id: entry[:order_id]}).first
        if current
          current.state = entry[:state]
        else
          current = Invoice.new(entry)
        end
        current.save(validate: false)
      end
    else
      success = false
    end
    success
  end
end
