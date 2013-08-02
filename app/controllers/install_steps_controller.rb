class InstallStepsController < ApplicationController
  before_filter :signed_in_user
  include Wicked::Wizard

  prepend_before_filter :set_steps

  def show
    @user = current_user
    case step
    when :update_rails
      if @user.rails_version == "4.0"
        skip_step
      end
    end
    render_wizard
  end

  def update
    @user = current_user
    case step
    when :choose_os
      @user.os = params[:os]
    when :choose_os_version
      @user.os_version = params[:os_version]
    when :verify_installation
      @user.rails_version = params[:rails_version]
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
      if %w(10.8 10.7 10.6).include?( params[:os_version] || current_user.try(:os_version) )
        steps = [ :choose_os,
                  :choose_os_version,
                  :railsinstaller,
                  :find_the_command_line,
                  :verify_installation,
                  :update_rails,
                  :configure_git,
                  text_editor_step,
                  :create_your_first_app,
                  :see_it_live]
      elsif ( params[:os_version] || current_user.try(:os_version) ) == "10.5 or below"
        steps = [ :choose_os,
                  :choose_os_version,
                  :install_xcode,
                  :find_the_command_line,
                  :install_homebrew,
                  :install_git,
                  :configure_git,
                  :install_rvm_and_ruby,
                  :install_rails,
                  text_editor_step,
                  :create_your_first_app,
                  :see_it_live]
      else
        steps = [ :choose_os,
                  :choose_os_version]
      end
    end

    def windows_steps
      [:choose_os, :railsinstaller, :configure_git, text_editor_step, :create_your_first_app,
                  :see_it_live]
    end

    def text_editor_step
      if current_user.os_version == "10.5 or below"
        :textmate
      else
        :sublime_text
      end
    end

    def finish_wizard_path
      wizard_path(:congratulations)
    end
end
