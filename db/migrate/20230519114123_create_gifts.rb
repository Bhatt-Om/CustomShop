class CreateGifts < ActiveRecord::Migration[7.0]
  def change
    create_table :gifts do |t|
      t.text :description
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
