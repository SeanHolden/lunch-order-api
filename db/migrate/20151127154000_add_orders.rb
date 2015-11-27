class AddOrders < ActiveRecord::Migration
  def change
    create_table(:orders) do |t|
      t.text :text_order, null: false
      t.string :name

      t.timestamps null: false
    end
  end
end
