class MainController < ApplicationController
  def index
  end

  def test
    render layout: "application"
  end

  def congratulations
    render layout: "install_steps"
  end
end
