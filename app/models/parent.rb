class Parent < ApplicationRecord
  has_and_belongs_to_many :children
  has_and_belongs_to_many :mass_messages

  def admin?
    is_admin
  end

  def current_children
    children.select { |c| c.years.map(&:current_year).include?(true) }
  end

  def formatted_phone_number
    Phoner::Phone.parse(phone_number, country_code: "1").to_s
  end
end
