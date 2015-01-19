class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.new config: session.fetch(:user, {})
  end

  def os; params[:os] || current_user.os; end
  def os_version; params[:os_version] || current_user.os_version; end
  def ruby_version; current_user.ruby_version; end
  def rails_version; current_user.rails_version; end

  def mac?; os =~ /Mac/; end
  def windows?; os =~ /Windows/; end

  helper_method :mac?, :windows?, :current_user, :os_version
end
