class WelcomeController < ApplicationController
  def index
    # This cookie will be deleted when the user's browser is closed.
    # cookies[:curso] = "Curso de Ruby on Rails [COOKIE]"
    # session[:curso] = "Curso de Ruby on Rails da UDEMY [SESSION]"
  end
end
