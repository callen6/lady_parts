class FilmsController < ApplicationController

  def index
    @films = Film.all
    @films.to_json
  end

end