module SessionsHelper

  def sign_in(user)
    cookies.permanent[:user_id] = user.id
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(id: cookies[:user_id]) if cookies[:user_id]
  end

  def signed_in_user
    unless signed_in?
      create_guest_user
    end
  end

  def sign_out
    current_user = nil
    cookies.delete(:user_id)
  end

  def create_guest_user
    @user = User.new_guest
    @user.save
    sign_in @user
  end

end
