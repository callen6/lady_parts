class FilmsController < ApplicationController
    respond_to :html, :json

  def index
  end

  def cast
  	respond_with Film.where(bechdel_rating: 1..3)
  end

  def barchart
    year_range = params[:year_range]
    start_year = year_range["start_year"]
    end_year = year_range["end_year"]

    respond_with Film.where(critics_score: 1..100).where('year >= ?', start_year).where('year <= ?', end_year).order('year asc')
  end

end