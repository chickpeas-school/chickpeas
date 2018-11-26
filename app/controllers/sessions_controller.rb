class SessionsController < ApplicationController

  def new; end

  def create
    parent = Parent.find_by(email: params[:parent_email])

    respond_to do |format|
      if parent.nil?
        flash.alert = 'Unable to find email address; please ensure that you entered it correctly.'
        format.html { redirect_to login_path }
        format.json { render json: { message: 'Unable to find email address' }, status: :error, code: 404 }
      else
        session[:parent_id] = parent.id

        format.html { redirect_to root_path, notice: 'Thank you for logging in!' }
        format.json { render json: { message: "ok" }, status: :created }
      end
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
