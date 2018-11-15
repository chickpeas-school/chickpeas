class Parents::ChildrenController < ApplicationController
  before_action :set_parent, only: [:new, :create, :destroy]
  before_action :set_child, only: [:destroy]

  def new
    @child = Child.new
  end

  def create
    @child = Child.new(child_params)

    respond_to do |format|
      if @child.save
        @parent.children << @child

        format.html { redirect_to @parent, notice: 'Child successfully created.' }
        format.json { render :show, status: :created, location: @child }
      else
        format.html { render :new }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @child.destroy

    respond_to do |format|
      format.html { redirect_to years_path, notice: "Child was successfully delete from: #{@parent.name}"}
      format.json { head :no_content }
    end
  end

  private

  def set_parent
    @parent = Parent.find(params[:parent_id])
  end

  def child_params
    params.require(:child).permit(:first_name, :last_name, :age)
  end
end
