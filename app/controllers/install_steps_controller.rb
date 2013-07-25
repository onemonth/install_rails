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
    when :choose_os
      @user.os = params[:os]
    when :choose_os_version
      @user.os_version = params[:os_version]
    end
    render_wizard @user
  end

  private
    def set_steps
      if ( params[:os] || current_user.try(:os) ) == "Mac"
        self.steps = mac_steps
      elsif ( params[:os] || current_user.try(:os) ) == "Windows"
        self.steps = windows_steps
      else
        self.steps = [:choose_os]
      end
    end

    def mac_steps
      steps = [:choose_os, :choose_os_version, :railsinstaller, :update_rails, text_editor_step, :install_rvm_and_ruby]
    end

    def windows_steps
      [:choose_os, :choose_os_version]
    end

    def text_editor_step
      if current_user.os_version == "10.5"
        :textmate
      else
        :sublime_text
      end
    end
end
