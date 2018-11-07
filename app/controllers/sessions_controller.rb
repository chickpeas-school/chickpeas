class SessionsController < ApplicationController

  def new; end

  def create
    parent = Parent.find_by!(email: params[:parent_email])

    session[:parent_id] = parent.id

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Thank you for logging in!' }
      format.json { render json: { message: "ok" }, status: :created }
    end
  end

  def destroy
    session[:parent_id] = nil

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Thank you for logging out!' }
      format.json { render json: { message: "ok" }, status: :created }
    end
  end
end
