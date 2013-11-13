class FilmsController < ApplicationController
    respond_to :html, :json

  def index
    respond_with Film.all
  end

<<<<<<< HEAD
  def cast
  	respond_with Film.where(bechdel_rating: '3')
  end

=======
  def barchart
    year_range = params[:year_range]
    start_year = year_range["start_year"]
    end_year = year_range["end_year"]
    respond_with Film.where(critics_score: 1..100).where('year >= ?', start_year).where('year <= ?', end_year).order('year asc')
  end

  # def bubblechart
  #   respond_with Film.where(critics_score: 1..100)
  # end

>>>>>>> 9a3dd5a50e5ef8d21d847507741ecd9c046b950e
end