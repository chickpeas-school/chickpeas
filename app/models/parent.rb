class Parent < ApplicationRecord
  has_and_belongs_to_many :children

  def admin?
    is_admin
  end
end
