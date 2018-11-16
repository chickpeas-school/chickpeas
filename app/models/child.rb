class Child < ApplicationRecord
  has_and_belongs_to_many :years
  has_and_belongs_to_many :parents

  has_many :days_for_sale, class_name: "SaleableDay", foreign_key: "seller_id"
  has_many :days_bought, class_name: "SaleableDay", foreign_key: "buyer_id"

  def days_for_sale?
    !days_for_sale.empty?
  end

  def days_bought?
    !days_bought.empty?
  end
end
