class Year < ApplicationRecord
  has_and_belongs_to_many :children

  def self.current_year
    find_by(current_year: true)
  end

  def self.current_parents
    self.current_year.children.map(&:parents).flatten.uniq
  end
end
