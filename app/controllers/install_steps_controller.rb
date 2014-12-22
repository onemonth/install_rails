class InstallStepsController < ApplicationController
  before_filter :signed_in_user
  include Wicked::Wizard

  prepend_before_filter :set_steps

  helper_method :mac?, :windows?, :os_version

  def show
    @user = current_user
    case step
    when :update_ruby
      skip_step if @user.ruby_version =~ /2.0/
    when :update_rails
      skip_step if @user.rails_version =~ /4.0/
    end
    render_wizard
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    render_wizard @user
  end

  private
    def os
      params[:os] || current_user.try(:os)
    end

    def mac?
      os =~ /Mac/
    end

    def windows?
      os =~ /Windows/
    end

    def get_steps
      if mac?
        mac_steps
      elsif windows?
        windows_steps
      elsif os == "Other"
        ubuntu_steps
      else
        [:choose_os]
      end
    end

    def set_steps
      self.steps = get_steps
    end

    def os_version
      params[:os_version] || current_user.try(:os_version)
    end

    def mac_steps
      case os_version
      when "10.8", "10.7", "10.6"
        [ :choose_os,
          :choose_os_version,
          :railsinstaller,
          :find_the_command_line,
          :verify_ruby_version,
          :update_ruby,
          :verify_rails_version,
          :update_rails,
          :configure_git,
          text_editor_step,
          :create_your_first_app,
          :see_it_live]
      when "10.9 or 10.10", "10.5 or below"
        [ :choose_os,
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
        [ :choose_os,
          :choose_os_version]
      end
    end

    def windows_steps
      [ :choose_os,
        :railsinstaller_windows,
        text_editor_step,
        :find_git_bash,
        :create_your_first_app,
        :see_it_live]
    end

    def ubuntu_steps
      [:choose_os, :rails_for_linux_and_other]
    end

    def text_editor_step
      if os_version =~ /10.5/
        :textmate
      else
        :sublime_text
      end
    end

    def finish_wizard_path
      wizard_path(:congratulations)
    end

  private
    def user_params
      params.permit(:os, :os_version, :ruby_version, :rails_version)
    end
end
