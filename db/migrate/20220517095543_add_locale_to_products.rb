class AddLocaleToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :locale, :string
  end
end
