class Years::ChildrenController < ApplicationController
  before_action :set_year, only: [:new, :create, :destroy]
  helper ChildrenHelper

  def new
    @existing_children = Child.all
    @child = Child.new
  end

  def create
    if params[:type] == :returning
      child = Child.find(params[:child_id])
    else
      date_of_birth = Date.parse(child_params[:dob]).strftime("%m/%d/%Y")
      days = helpers.day_checkboxes_to_string(child_params.slice(*helpers.day_symbols).to_h)

      child = Child.create(
        name: child_params[:name],
        dob: date_of_birth,
        days: days
      )
    end

    unless @year.children.map(&:id).include?(child.id)
      @year.children << child
    end

    respond_to do |format|
      format.html { redirect_to year_path(@year), notice: "Child was successfully added to: #{@year.value}"}
      format.json { render :show, status: :created, location: @year }
    end
  end

  def destroy
    child = Child.find(params[:id])
    @year.children = @year.children.reject { |c| c.id.eql?(child.id) }

    respond_to do |format|
      format.html { redirect_to year_path(@year), notice: "Child was successfully delete from: #{@year.value}"}
      format.json { head :no_content }
    end
  end

  private

  def set_year
    @year = Year.find(params[:year_id])
  end

  def child_params
    params[:child].permit(:name, :dob, :days_monday, :days_tuesday, :days_wednesday, :days_thursday, :days_friday)
  end
end
