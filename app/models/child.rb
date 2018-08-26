class Child < ApplicationRecord
  belongs_to :parent
  has_many :buyer_sellers
  has_many :saleable_days, through: :buyer_sellers do
    def days_sold
      where("buyer_sellers.is_seller = ?", true)
    end

    def days_bought
      where("buyer_sellers.is_buyer = ?", true)
    end
  end

  def has_days_sold?
    saleable_days.days_sold.count > 0
  end

  def has_days_bought?
    saleable_days.days_bought.count > 0
  end
end
