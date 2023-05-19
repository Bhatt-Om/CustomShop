class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :category
      t.text :product_description
      t.string :size
      t.string :color
      t.string :material
      
      t.timestamps
    end
  end
end
