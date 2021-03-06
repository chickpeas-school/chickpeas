class SessionsController < ApplicationController

  def new; end

  def create
    # legacy emails are not all lower case. I decided to do this to remove case sensitivity rather than
    # running a migration but maybe I'll do that later
    parent = Parent.where('lower(email) = ?', params[:parent_email].downcase).first

    respond_to do |format|
      if parent.nil?
        flash.alert = 'Unable to find email address; please ensure that you entered it correctly.'
        format.html { redirect_to new_parent_session_path }
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
