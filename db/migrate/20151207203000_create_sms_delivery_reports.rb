class CreateSmsDeliveryReports < ActiveRecord::Migration
  def change
    create_table(:sms_delivery_reports) do |t|
      t.text :status, null: false

      t.timestamps null: false
    end
  end
end
