class SaleableDay < ApplicationRecord
  belongs_to :buyer, class_name: "Parent", optional: true
  belongs_to :seller, class_name: "Parent"

  scope :for_sale, -> { where(buyer: nil) }
  scope :sold, -> { where.not(buyer: nil) }

  # TODO
  # has_one :child
end
