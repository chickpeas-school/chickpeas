class ChildrenController < ApplicationController
  before_action :set_child, only: %i[show]

  def index
    @children = Child.all
  end

  def show; end

  private

  def set_child
    @child = Child.find(params[:id])
  end
end
