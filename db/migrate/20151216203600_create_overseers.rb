class CreateOverseers < ActiveRecord::Migration
  def change
    create_table(:overseers) do |t|
      t.string :user_name, null: false
      t.string :user_id, null: false

      t.timestamps null: false
    end
  end
end
