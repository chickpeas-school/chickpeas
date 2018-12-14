class EmailConfig < ApplicationRecord
  scope :saleable_day, -> { where(genre: "saleable_days").limit(1).first }

  def self.saleable_days_in_test_mode?
    self.saleable_day && self.saleable_day.testing
  end

  def self.saleable_distribution_email
    self.saleable_day && self.saleable_day.email
  end
end
