module WikisHelper
  def user_admin_or_premium?
    @current_user.role == 'admin' || 'premium'
  end
end
