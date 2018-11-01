class Parent < ApplicationRecord
  has_many :children

  def name
    "#{first_name} #{last_name}"
  end
end
