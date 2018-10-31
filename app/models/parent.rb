class Parent < ApplicationRecord
  has_and_belongs_to_many :years

  has_many :children
  has_many :days_sold, class_name: "SaleableDay", foreign_key: "seller_id"
  has_many :days_bought, class_name: "SaleableDay", foreign_key: "buyer_id"

  def name
    "#{first_name} #{last_name}"
  end
end
