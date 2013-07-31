class WelcomeController < ApplicationController
  def index
  end

  def test
    render layout: "application"
  end
end
