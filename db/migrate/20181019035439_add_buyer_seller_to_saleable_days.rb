class AddBuyerSellerToSaleableDays < ActiveRecord::Migration[5.2]
  def change
    add_reference :saleable_days, :buyer, index: true
    add_reference :saleable_days, :seller, index: true
  end
end
