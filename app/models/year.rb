class Year < ApplicationRecord
  has_and_belongs_to_many :parents
end
