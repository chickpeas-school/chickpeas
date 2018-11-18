class SaleableDay < ApplicationRecord
  belongs_to :buyer, class_name: "Child", optional: true
  belongs_to :seller, class_name: "Child"

  scope :for_sale, -> { where(buyer: nil) }
  scope :sold, -> { where.not(buyer: nil) }

  self.per_page = 10

  # TODO
  # has_one :child
  #
  def start_time
    date
  end

  def sold?
    !buyer.nil?
  end
end
