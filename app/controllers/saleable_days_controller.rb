class SaleableDaysController < ApplicationController

  def index
    @days = SaleableDay.for_sale
  end

  def new
    @day = SaleableDay.new
    @child = Child.find(params[:child_id])
  end

  def edit
    @day = SaleableDay.find(params[:id])
    @children = Child.all.reject { |ch| ch.id == @day.seller.id }
  end

  def update
    @day = SaleableDay.find(params[:id])
    @child = Child.find(params[:saleable_day][:child_id])

    buyer_params = {
      child_id: @child.id,
      saleable_day_id: @day.id,
      is_seller: false,
      is_buyer: true
    }

    @bs = BuyerSeller.new(buyer_params)

    respond_to do |format|
      if @bs.save
        format.html { redirect_to @child.parent, notice: 'Day has been bought' }
        format.json { render :show, status: :created, location: @child.parent }
      else
        format.html { render :edit }
        format.json { render json: @bs.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @day = SaleableDay.new(day_params)
    @child = Child.find(params[:saleable_day][:child_id])
    @day.seller = @child

    respond_to do |format|
      if @day.save
        format.html { redirect_to @child.parent, notice: 'Day was successfully recorded for sale' }
        format.json { render :show, status: :created, location: @child.parent }
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
