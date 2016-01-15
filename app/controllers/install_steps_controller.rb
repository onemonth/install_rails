class InstallStepsController < ApplicationController
  include Wicked::Wizard

  prepend_before_action :set_steps
  after_action :set_session

  rescue_from Wicked::Wizard::InvalidStepError, with: ->{ redirect_to root_path }

  def show
    case step
    when :update_ruby
      skip_step if ruby_version =~ /2.0/
    when :update_rails
      skip_step if rails_version =~ /4.0/
    end
    render_wizard
  end

  def update
    current_user.update(user_params)
    render_wizard current_user
  end

  private

    def set_steps
      self.steps = case
                   when mac?          then mac_steps
                   when windows?      then windows_steps
                   when os == "Linux" then ubuntu_steps
                   else [:choose_os]
                   end
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
      when "10.11", "10.10", "10.9"
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
        [:choose_os, :choose_os_version]
      end
    end

    def windows_steps
      [:choose_os, :railsinstaller_windows, text_editor_step, :find_git_bash, :update_rubygems, :create_your_first_app, :see_it_live]
    end

    def ubuntu_steps
      [:choose_os, :rails_for_linux_and_other]
    end

    def text_editor_step
       :sublime_text
    end

    def finish_wizard_path
      congratulations_path
    end

    def user_params
      params.permit(:os, :os_version, :ruby_version, :rails_version)
    end

    def set_session
      session[:user] = current_user.config
    end
end
