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
    director_passing_films = params[:director_passing_films]
    dpm = director_passing_films["dpm"]
    respond_with Film.where(dpm: 1..12).where('dpm = ?', dpm)
  end

end