class DropBuyerSellersTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :buyer_sellers
  end
end
