class Child < ApplicationRecord
  has_and_belongs_to_many :years
  has_and_belongs_to_many :parents

  has_many :days_for_sale, class_name: "SaleableDay", foreign_key: "seller_id"
  has_many :days_bought, class_name: "SaleableDay", foreign_key: "buyer_id"

  def days_for_sale?
    !days_for_sale.empty?
  end

  def days_bought?
    !days_bought.empty?
  end

  def current_year?
    years.map(&:current_year).include?(true)
  end

  def dob_split
    dob.split("/")
  end

  def year_of_birth
    yr = dob_split[2]
    yr.length.eql?(4) ? yr.to_i : (2000 + yr.to_i)
  end

  def month_of_birth
    dob_split[0].to_i
  end

  def date_of_birth
    dob_split[1].to_i
  end

  def time_of_birth
    Date.new(year_of_birth, month_of_birth, date_of_birth).to_time
  end

  def born_years_ago
    (Time.now - time_of_birth) / 1.year
  end

  def eligible?
    born_years_ago < 6
  end
end
