class Years::ChildrenController < ApplicationController
  before_action :set_year, only: [:new, :create, :destroy]

  def new
    @children = Child.all.reject { |c| c.years.map(&:value).include?(@year.value) }
  end

  def create
    child = Child.find(params[:child_id])

    unless @year.children.map(&:id).include?(child.id)
      @year.children << child
    end

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
end
