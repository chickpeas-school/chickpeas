class Year < ApplicationRecord
  has_and_belongs_to_many :children

  before_create :ensure_unique_current_year

  class << self
    def current_year
      find_by(current_year: true)
    end

    def current_parents
      current_year.children.map(&:parents).flatten.uniq
    end
  end

  def ensure_unique_current_year
    if current_year
      Year.where(current_year: true).each do |y|
        y.current_year = false
        y.save
      end
    end
  end
end
