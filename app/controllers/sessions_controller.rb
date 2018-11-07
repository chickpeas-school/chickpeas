class SessionsController < ApplicationController

  def new; end

  def create
    parent = Parent.find_by!(email: params[:parent_email])

    session_parent_id = parent.id

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Thank you for logging in!' }
      format.json { render json: { message: "ok" }, status: :created }
    end
  end

  def destroy
  end
end
