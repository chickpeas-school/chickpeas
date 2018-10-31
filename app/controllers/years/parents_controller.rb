class Years::ParentsController < ApplicationController
  before_action :set_year, only: [:new, :create, :destroy]

  def new
    @parents = Parent.all.reject { |p| p.years.map(&:value).include?(@year.value) }
  end

  def create
    parent = Parent.find(params[:parent_id])

    unless @year.parents.map(&:id).include?(parent.id)
      @year.parents << parent
    end

    respond_to do |format|
      format.html { redirect_to years_years_path, notice: "Parent was successfully added to: #{@year.value}"}
      format.json { render :show, status: :created, location: @year }
    end
  end

  def destroy
    parent = Parent.find
  end

  private

  def set_year
    @year = Year.find(params[:year_id])
  end
end
