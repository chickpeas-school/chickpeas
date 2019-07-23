class Years::ChildrenController < ApplicationController
  before_action :set_year, only: [:new, :create, :destroy]
  helper ChildrenHelper

  def new
    @child = Child.new
  end

  def create
    binding.pry

    date_of_birth = Date.parse(child_params[:dob]).strftime("%m/%d/%Y")

    child = Child.find(params[:child_id])

    @year.children << child

    respond_to do |format|
      format.html { redirect_to years_path, notice: "Child was successfully added to: #{@year.value}"}
      format.json { render :show, status: :created, location: @year }
    end
  end

  def destroy
    child = Child.find(params[:child_id])
    @year.children = @year.children.reject { |c| c.id.eql?(child.id) }

    respond_to do |format|
      format.html { redirect_to years_path, notice: "Child was successfully delete from: #{@year.value}"}
      format.json { head :no_content }
    end
  end

  private

  def set_year
    @year = Year.find(params[:year_id])
  end

  def child_params
    params[:child].permit(:name, :dob)
  end
end
