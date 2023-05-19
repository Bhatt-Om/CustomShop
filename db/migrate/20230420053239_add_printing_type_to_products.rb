class AddPrintingTypeToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :printing_type, :text
  end
end
