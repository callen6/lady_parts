class FilmsController < ApplicationController
    respond_to :html, :json

  def index
    respond_with Film.where(critics_score: 1..100)
  end
end