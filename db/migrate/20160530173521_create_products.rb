class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :sku, unique: true, null: false
      t.string :name, null: false
      t.decimal :price, :precision => 8, :scale => 2, null: false
      t.integer :quantity_available, null: false

      t.timestamps null: false
    end
  end
end
