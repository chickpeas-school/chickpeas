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
    @day.buyer = @child

    respond_to do |format|
      if @day.save
        format.html { redirect_to saleable_days_path, notice: 'Day has been bought' }
        format.json { render :show, status: :created, location: saleable_days_path }
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
