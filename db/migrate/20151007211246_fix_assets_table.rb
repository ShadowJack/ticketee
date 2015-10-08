class FixAssetsTable < ActiveRecord::Migration
  def change
    add_column :assets, :asset, :string
    add_column :assets, :ticket_id, :integer, foreign_key: true
    remove_column :tickets, :asset, :string
  end
end
