class Parent < ApplicationRecord
  has_many :children

  def name
    "#{first_name} #{last_name}"
  end

  def admin?
    is_admin
  end
end
