class SaleableDay < ApplicationRecord
  belongs_to :buyer, class_name: "Child", optional: true
  belongs_to :seller, class_name: "Child", optional: true

  scope :for_sale, -> { where(buyer: nil) }
  scope :sold, -> { where.not(buyer: nil) }
  scope :upcoming, -> { where("date > ?", (Time.now - 2.day)).order(date: :asc, created_at: :asc) }

  self.per_page = 10

  validates :date, presence: true

  class << self
    def find_first_on_date(saleable_day_id)
      days = SaleableDay.all
      saleable_day = days.find(saleable_day_id)
      saleable_day_date = saleable_day.date.to_date

      other_days = days.reject { |d| d.id.eql?(saleable_day_id) }
      other_days.select { |d| saleable_day_date == d.date.to_date }.sort_by(&:created_at).first || saleable_day
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
