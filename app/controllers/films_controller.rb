class FilmsController < ApplicationController
    respond_to :html, :json

  def index

  end

  def barchart
    year_range = params[:year_range]
    start_year = year_range["start_year"]
    end_year = year_range["end_year"]
    respond_with Film.where(critics_score: 1..100).where('year >= ?', start_year).where('year <= ?', end_year).order('year asc')
  end

  def director
    director_films = params[:director_films]
    directors = director_films["directors"]
    respond_with Film.where(bechdel_rating: 3).where('director = ?', directors).order('directors asc')
  end

end