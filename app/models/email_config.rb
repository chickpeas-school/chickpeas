# EmailConfig was built with the intention of testing the SaleableDayMailer in `production` without
# email everyone within the system. There are 2 primary pieces of information that are relevant:
# 1. Is it for `testing`?
# 2. What is the main distribution email address for annoucing that a day has been put up for sale? At present, parents@chickpeas.org is an email group address that distributes emails to all the parents.
#
# Example for testing:
# ```
# {
#   email: "brad@prudl.com",
#   testing: true,
#   genre: "saleable_days",
#   description: "default testing email config"
# }
# ```
#
# Example for live:
# ```
# {
#   email: "parents@chickpeas.org",
#   testing: false,
#   genre: "saleable_days",
#   description: "default production email config"
# }
# ```
#
SALEABLE_DAYS_GENRE = "saleable_days"

class EmailConfig < ApplicationRecord

  scope :saleable_days_config, -> { where(genre: SALEABLE_DAYS_GENRE).limit(1).first }

  def self.saleable_days_in_test_mode?
    self.saleable_days_config && self.saleable_days_config.testing
  end

  # saleable_distribution_email checks to see if the EmailConfig.saleable_days_config in the DB
  # has an email address. If it does have an email address, then that is the email address returned
  def self.saleable_distribution_email
    self.saleable_days_config && self.saleable_days_config.email
  end
end
