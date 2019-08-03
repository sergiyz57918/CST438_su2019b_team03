class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer "itemId" , null: false
      t.integer "customerId" , null: false
      t.text "description", null: false
      t.decimal "price", precision: 5, scale: 2, default: "0.0"
      t.decimal "award", precision: 5, scale: 2, default: "0.0"
      t.decimal "total", precision: 5, scale: 2, default: "0.0"
      t.timestamps
    end
  end
end
