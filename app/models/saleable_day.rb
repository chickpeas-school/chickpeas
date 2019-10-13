class SaleableDay < ApplicationRecord
  belongs_to :buyer, class_name: "Child", optional: true
  belongs_to :seller, class_name: "Child", optional: true

  scope :for_sale, -> { where(buyer: nil) }
  scope :sold, -> { where.not(buyer: nil, seller: nil) }
  scope :upcoming, -> { where("date > ?", (Time.now - 2.day)).order(date: :asc, created_at: :asc) }

  self.per_page = 10

  validates :date, presence: true

  class << self
    # was giving priority to child who put date up for sale / buy first
    # for now, let's just allow parents to decide manually, and build priority
    # more robustly later
    def find_first_available_on_date(saleable_day_id)
      SaleableDay.find(saleable_day_id)
    end
  end

  def start_time
    date
  end

  def sold?
    seller && buyer
  end

  def buyer_or_sellers_name
    return seller.name if seller
    buyer.name
  end
end
