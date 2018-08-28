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

  def self.for_sale
    all.select { |day| day.for_sale? }
  end

  def for_sale?
    !buyer_sellers.map(&:is_buyer).include?(true)
  end

  def seller
    children.seller
  end

  def buyer
    children.buyer
  end
end
