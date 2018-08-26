class CreateBuyerSellers < ActiveRecord::Migration[5.2]
  def change
    create_table :buyer_sellers do |t|
      t.belongs_to :child, index: true
      t.belongs_to :saleable_day, index: true
      t.boolean :is_buyer
      t.boolean :is_seller
    end
  end
end
