class Child < ApplicationRecord
  belongs_to :parent

  def name
    "#{first_name} #{last_name}"
  end

  def days_for_sale?
    !days_for_sale.empty?
  end

  def days_for_sale
    @days_for_sale ||= SaleableDay.where(seller: self)
  end

  def days_bought?
    !days_bought.empty?
  end

  def days_bought
    @days_bought ||= SaleableDay.where(buyer: self)
  end
end
