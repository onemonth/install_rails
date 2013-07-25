class WelcomeController < ApplicationController
  def index
  end

  def template
    render layout: "application"
  end
end
