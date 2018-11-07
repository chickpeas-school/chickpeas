module SessionsHelper
  def current_user
    @current_user ||= Parent.find(session_parent_id) if session_parent_id.present?
  end

  def admin_user?
    current_user && !!current_user.admin?
  end

  def logged_in?
    !current_user.nil?
  end

  def session_parent_id
    session[:parent_id]
  end
end
