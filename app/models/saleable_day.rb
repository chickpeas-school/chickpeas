class SaleableDay < ApplicationRecord
  has_many :buyer_sellers
  has_many :children, through: :buyer_sellers
end
