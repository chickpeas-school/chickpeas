class Children::ParentsController < ApplicationController
  before_action :set_child

  def new
    @parent = @child.parents.new
  end

  def create
    @parent = @child.parents.create(parent_params)

    respond_to do |format|
      if @parent.save
        format.html { redirect_to child_path(@child), notice: "A Parent was successfully added to: #{@child.name}"}
        format.json { render :show, status: :created, location: @child }
      else
        format.html { render :new }
        format.json { render json: @child.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @parent = @child.parents.find(params[:id])
    respond_to do |format|
      format.html { redirect_to child_path(@child), notice: "The parent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_child
    @child = Child.find(params[:child_id])
  end

  def parent_params
    params.permit(:name, :email, :phone_number, :job, :address)
  end
end
