class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :information, null: false
      t.integer :category_id, null: false
      t.integer :condition_id, null: false
      t.integer :delivery_charge_id, null: false
      t.integer :delivery_area_id, null: false
      t.integer :delivery_day_id, null: false
      t.integer :selling_price, null: false
      t.references :user, null: false, foreign_ken: true

      t.timestamps
    end
  end
end


