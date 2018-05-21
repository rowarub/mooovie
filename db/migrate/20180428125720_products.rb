class Products < ActiveRecord::Migration
  def change
    add_column :products, :director, :string
    add_column :products, :detial, :text
    add_column :products, :open_date, :string
  end
end
