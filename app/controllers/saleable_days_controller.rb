class SaleableDaysController < ApplicationController

  def index
    @days = SaleableDay.all
  end

  def new
    @day = SaleableDay.new
    @child = Child.find(params[:child_id])
  end

  def create
    @day = SaleableDay.new(day_params)

    respond_to do |format|
      if @day.save
        @child = Child.find(params[:saleable_day][:child_id])

        buy_sell_params = {
          child_id: @child.id,
          saleable_day_id: @day.id,
          is_seller: true,
          is_buyer: false
        }

        @bs = BuyerSeller.new(buy_sell_params)

        if @bs.save
          format.html { redirect_to @child.parent, notice: 'Day was successfully recorded for sale' }
          format.json { render :show, status: :created, location: @child.parent }
        else
          format.html { render :new }
          format.json { render json: @bs.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def day_params
    params.require(:saleable_day).permit(:date)
  end
end
