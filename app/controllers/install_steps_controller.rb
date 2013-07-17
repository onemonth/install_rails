class InstallStepsController < ApplicationController
  before_filter :signed_in_user
  include Wicked::Wizard

  prepend_before_filter :set_steps

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

  private
    def set_steps
      if ( params[:os] || current_user.os ) == "Mac"
        self.steps = mac_steps
      elsif ( params[:os] || current_user.os ) == "Windows"
        self.steps = windows_steps
      else
        self.steps = [:choose_operating_system]
      end
    end

    def mac_steps
      [:choose_operating_system, :mac, :os_version]
    end

    def windows_steps
      [:choose_operating_system, :pc]
    end
end
