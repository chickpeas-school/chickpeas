class ChildrenController < ApplicationController
  before_action :set_parent
  before_action :set_child, only: %i[show edit update destroy]

  def index
    @children = @parent.children
  end

  def show; end

  def new
    @child = Child.new
  end

  def create
    attrs = child_params.merge(parent: @parent)
    @child = Child.new(attrs)

    respond_to do |format|
      if @child.save
        format.html { redirect_to @parent, notice: 'Child successfully created.' }
        format.json { render :show, status: :created, location: @child }
      else
        format.html { render :new }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_parent
    @parent = Parent.find(params[:parent_id])
  end

  def set_child
    @child = Child.find(params[:id])
  end

  def child_params
    params.require(:child).permit(:last_name, :first_name, :age)
  end
end
