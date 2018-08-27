class SaleableDay < ApplicationRecord
  has_many :buyer_sellers
  has_many :children, through: :buyer_sellers do
    def seller
      where("buyer_sellers.is_seller = ?", true).first
    end

    def buyer
      where("buyer_sellers.is_buyer = ?", true).first
    end
  end

  def seller
    children.seller
  end

  def buyer
    children.buyer
  end
end
