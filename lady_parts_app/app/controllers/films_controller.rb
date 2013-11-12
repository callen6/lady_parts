class FilmsController < ApplicationController
    respond_to :html, :xml, :json

  def index
    respond_with Film.all
  end
end