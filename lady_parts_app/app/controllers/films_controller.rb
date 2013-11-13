class FilmsController < ApplicationController
    respond_to :html, :json

  def index
    respond_with Film.where(critics_score: 1..100)
  end

  def cast
  	respond_with Film.where(bechdel_rating: 3)
  end

end