# EmailConfig was built with the intention of active the SaleableDayMailer in `production` without
# email everyone within the system. There are 2 primary pieces of information that are relevant:
# 1. Is it for `active`?
# 2. What is the main distribution email address for annoucing that a day has been put up for sale? 
#    At present, parents@chickpeas.org is an email group address that distributes emails to all the parents.
#
# Example for active:
# ```
# {
#   email: "brad@prudl.com",
#   active: false,
#   genre: "saleable_days",
#   description: "default active email config"
# }
# ```
#
# Example for live:
# ```
# {
#   email: "parents@chickpeas.org",
#   active: true,
#   genre: "saleable_days",
#   description: "default production email config"
# }
# ```
#
SALEABLE_DAYS_GENRE = "saleable_days"
SALEABLE_DAYS_FALLBACK_GENRE = "saleable_days_fallback"

class EmailConfig < ApplicationRecord
  belongs_to :parent, optional: true

  # this was, for some reason, returning all email configs. rather than look into why it was breaking
  # I just went with a simpler and less performant solution, in the interest of just getting things working

  # scope :app_configs, ->{ where(parent_id: nil) }
  # scope :saleable_days_fallback_config, ->{ where(parent_id: nil, genre: SALEABLE_DAYS_FALLBACK_GENRE).limit(1).first || nil }

  def self.saleable_days_fallback_config
    self.where(parent_id: nil, genre: SALEABLE_DAYS_FALLBACK_GENRE).limit(1).first
  end

  def self.saleable_days_fallback_active?
    fallback = saleable_days_fallback_config
    fallback && fallback.active
  end

  # saleable_distribution_email checks to see if the EmailConfig.saleable_days_fallback_config in the DB
  # has an email address. If it does have an email address, then that is the email address returned
  def self.saleable_distribution_fallback_email
    fallback = saleable_days_fallback_config
    fallback && fallback.email
  end

  def display_genre
    case genre
    when SALEABLE_DAYS_GENRE
      return "Days for Sale"
    when SALEABLE_DAYS_FALLBACK_GENRE
      return "Fallback Email Configuration"
    else
      return genre
    end
  end
end
