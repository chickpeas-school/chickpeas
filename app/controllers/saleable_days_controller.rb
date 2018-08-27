class SaleableDaysController < ApplicationController

  def index
    @days = SaleableDay.all
  end
end
