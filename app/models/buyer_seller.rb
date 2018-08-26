class BuyerSeller < ApplicationRecord
  belongs_to :child
  belongs_to :saleable_day
end
