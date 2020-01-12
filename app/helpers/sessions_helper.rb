module SessionsHelper
  def admin_user?
    parent_signed_in? && !!current_parent.admin?
  end
end
