class SaleableDaysController < ApplicationController
  before_action :logged_in?, only: [:edit, :create, :new, :update]

  def index
    @days = SaleableDay.all
    @list_days = SaleableDay.upcoming.paginate(page: params[:page])
  end

  def new
    @day = SaleableDay.new
    @child = Child.find(params[:child_id])

    if params[:type] == :sell
      template = "new_sell"
    elsif params[:type] == :buy
      template = "new_buy"
    else
      template = "new"
    end

    render template
  end

  def edit
    @day = SaleableDay.find(params[:id])
    buyer_seller_id = is_buy? ? @day.seller.id : @day.buyer.id
    @children = current_user.eligible_children.reject { |ch| ch.id == buyer_seller_id }

    if params[:type] == :sell
      template = "edit_sell"
    elsif params[:type] == :buy
      template = "edit_buy"
    else
      template = "edit"
    end

    render template
  end

  def update
    @day = SaleableDay.find(params[:id])
    child_id = is_buy? ? params[:saleable_day][:buyer_id] : params[:saleable_day][:seller_id]
    @child = Child.find(child_id)

    if is_buy?
      @day.buyer = @child
    else
      @day.seller = @child
    end

    respond_to do |format|
      if @day.save
        if is_buy?
          SaleableDayMailer.with(day: @day).day_purchased.deliver_later
        else
          SaleableDayMailer.with(day: @day).day_sold.deliver_later
        end

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
    child_id = is_buy? ? params[:saleable_day][:buyer_id] : params[:saleable_day][:seller_id]
    @child = Child.find(child_id)

    if is_buy?
      @day.buyer = @child
    else
      @day.seller = @child
    end

    respond_to do |format|
      if @day.save
        if is_buy?
          SaleableDayMailer.with(day: @day).day_posted_for_purchase.deliver_later
        else
          SaleableDayMailer.with(day: @day).day_put_on_sale.deliver_later
        end

        format.html { redirect_to saleable_days_path, notice: 'Day was successfully recorded for sale' }
        format.json { render :show, status: :created, location: @child.parent }
      else
        template = is_buy? ? 'new_buy' : 'new_sell'
        format.html { render template }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_buyer
    @day = SaleableDay.find(params[:id])

    @day.buyer = nil

    if @day.save
      respond_to do |format|
        format.html { redirect_to saleable_days_path, notice: "Buyer was successfully removed" }
        format.json { render :show, status: :ok, location: @day }
      end
    else
      respond_to do |format|
        format.html { redirect_to saleable_days_path, notice: "Unable to remove the Buyer" }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_seller
    @day = SaleableDay.find(params[:id])

    @day.seller = nil

    if @day.save
      respond_to do |format|
        format.html { redirect_to saleable_days_path, notice: "Seller was successfully removed" }
        format.json { render :show, status: :ok, location: @day }
      end
    else
      respond_to do |format|
        format.html { redirect_to saleable_days_path, notice: "Unable to remove the Seller" }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    SaleableDay.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to saleable_days_path, notice: 'Day was successfully removed' }
      format.json { head :no_content }
    end
  end

  private

  def day_params
    params.require(:saleable_day).permit(:date)
  end

  def logged_in?
    redirect_to login_path unless super
  end

  def is_buy?
    params[:type] == :buy
  end
end
