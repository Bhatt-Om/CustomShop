class ChageColumnTypeInProducts < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :size, :text
    change_column :products, :color, :text
    change_column :products, :material, :text
  end
end
