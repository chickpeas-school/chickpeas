class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= Parent.find(session_parent_id) if session_parent_id
  end
  helper_method :current_user

  private

  def session_parent_id
    session[:parent_id]
  end

  def session_parent_id=(id)
    session[:parent_id] = id
  end

  def session_parent_id_destroy
    session[:parent_id] = nil
  end
end
