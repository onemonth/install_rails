class InstallStepsController < ApplicationController
  before_filter :signed_in_user
  include Wicked::Wizard

  steps :choose_operating_system, :mac, :os_version, :pc

  def show
    render_wizard
  end

  def update
    @user = current_user
    case step
    when :choose_operating_system
      @user.os = params[:os]
    when :mac
      @user.os_version = params[:os_version]
    end
    render_wizard @user
  end
end
