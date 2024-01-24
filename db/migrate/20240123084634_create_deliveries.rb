class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.string :post_code, null: false
      t.integer :delivery_area_id, null: false
      t.string :municipalities, null: false
      t.string :street_address, null: false
      t.string :building_name
      t.string :phone_number, null: false
      t.references :order, null: false, foreign_key: true
      t.timestamps


    end
  end
end
