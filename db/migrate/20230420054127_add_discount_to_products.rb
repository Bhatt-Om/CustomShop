class AddDiscountToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :discount, :string
  end
end
