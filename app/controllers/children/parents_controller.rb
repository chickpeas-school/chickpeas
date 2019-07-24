class Children::ParentsController < ApplicationController
  before_action :set_child

  def new

  end

  def create

  end

  def destroy

  end

  private

  def set_child
    @child = Child.find(params[:child_id])
  end
end
