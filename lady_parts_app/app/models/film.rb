class Film < ActiveRecord::Base
  include HTTParty
  default_params output: 'json'
  format :json
  before_create :default_values

# Order we want to do this in
# First!
def self.create_bechdel_movies
  movies = Film.get_all_movie_ids
  movies.each do |movie|
    film = Film.where(imdb_id: movie["imdbid"]).first || Film.create(imdb_id: movie["imdbid"], bechdel_id: movie["id"] )
  end
end

<<<<<<< HEAD
# Second!
def self.correct_imdb_ids
  movies = Film.all
  movies.each do |movie|
    if movie.imdb_id.to_s.length == 3
      # add 4 zeroes at the front
      movie.imdb_id = "0000" + movie.imdb_id.to_s
    elsif movie.imdb_id.to_s.length == 4
      movie.imdb_id = "000" + movie.imdb_id.to_s
    elsif movie.imdb_id.to_s.length == 5
      movie.imdb_id = "00" + movie.imdb_id.to_s
    elsif movie.imdb_id.to_s.length == 6
      movie.imdb_id = "0" + movie.imdb_id.to_s
    else
      movie.imdb_id = movie.imdb_id.to_s
=======
def self.correct_imdb_ids
  movies = Film.all
  movies.each do |movie|
    if movie.imdb_id.length == 3
      # add 4 zeroes at the front
      movie.imdb_id = "0000" + movie.imdb_id
    elsif movie.imdb_id.length == 4
      movie.imdb_id = "000" + movie.imdb_id
    elsif movie.imdb_id.length == 5
      movie.imdb_id = "00" + movie.imdb_id
    elsif movie.imdb_id.length == 6
      movie.imdb_id = "0" + movie.imdb_id
    else
      movie.imdb_id = movie.imdb_id
>>>>>>> d9c51ef8eae15503da1eba68d1695d302b48268f
    end
  end
end

<<<<<<< HEAD
# And third!
=======
>>>>>>> d9c51ef8eae15503da1eba68d1695d302b48268f
def self.add_tomatoes_movies
  movies = Film.all
  # binding.pry
  movies.each do |movie|
<<<<<<< HEAD
    tomato_movie = movie.get_tomato_movie_by_imdb_id(movie.imdb_id)
    if tomato_movie["error"] == "Could not find a movie with the specified id"
          movie.title = "No Rotten Tomatoes listing"
          movie.director = "No Rotten Tomatoes listing"
          movie.tomatoes_id = "0"
    else
      movie.title = tomato_movie["title"]  || "nope"
      movie.director = tomato_movie["abridged_directors"][0]["name"] || "nope"
      movie.tomatoes_id = tomato_movie["id"] || "0"
=======
      tomato_movie = movie.get_tomato_movie_by_imdb_id(movie.imdb_id.to_s)
      if tomato_movie["error"] == "Could not find a movie with the specified id" 
          movie.title = "No record in Rotten Tomatoes" 
          movie.director = "No record in Rotten Tomatoes"  
          movie.tomatoes_id = "0"
      else 
          movie.title = tomato_movie["title"] || "No record in Rotten Tomatoes" 
          movie.director = tomato_movie["abridged_directors"][0]["name"] || "No record in Rotten Tomatoes" 
          movie.tomatoes_id = tomato_movie["id"] || "0"
>>>>>>> d9c51ef8eae15503da1eba68d1695d302b48268f
    end
  end
end

# def self.add_bechdel_ratings
#   movies = Film.all
#   movies.each do |movie|
#     bechdel_rating = movie.get_movie_by_imdb_id(movie.imdb_id)
# end
 # Bechdel Test API methods using HTTParty

# then, if it doesn't, we can get all the movie id's
# this will only be used the first time, and then again weekly?
  # class method
  def self.get_all_movie_ids
    all_bechdel_films = get('http://bechdeltest.com/api/v1/getAllMovieIds')
  end

<<<<<<< HEAD
  def self.get_movie_by_imdb_id(imdbid)

    get('http://bechdeltest.com/api/v1/getMovieByImdbId', query: {imdb_id: imdbid})

    # bechdel_movie = get('http://bechdeltest.com/api/v1/getMovieByImdbId', query: {title: imdb_id, output: 'json'})
    # bechdel_movie.save

=======
  def get_movie_by_imdb_id(imdb_id)
    Film.get('http://bechdeltest.com/api/v1/getMovieByImdbId', query: {title: imdb_id})
>>>>>>> d9c51ef8eae15503da1eba68d1695d302b48268f
  end

# if the search is coming from user interaction, call api once
# for both bechdel test and rotten tomatoes 

  def get_movies_by_title(title) # returns any movie that matches, can be more than one

    Film.get('http://bechdeltest.com/api/v1/getMoviesByTitle', query: {title: title})

  end
  


  # Rotten Tomatoes API methods using HTTParty

  # if we take away self, we have to put in Film
  def get_tomato_movie_by_imdb_id(imdb_id)
   Film.get('http://api.rottentomatoes.com/api/public/v1.0/movie_alias.json?apikey=' + ENV['API_KEY'] + '&type=imdb&id=' + imdb_id, query: {imdb_id: imdb_id})


<<<<<<< HEAD
  def get_tomato_movie_by_imdb_id(imdb_id)
    Film.get('http://api.rottentomatoes.com/api/public/v1.0/movie_alias.json?apikey=' + ENV['API_KEY'] + '&type=imdb&id=' + imdb_id.to_s, query: {imdb_id: imdb_id})
=======
>>>>>>> d9c51ef8eae15503da1eba68d1695d302b48268f
  end

# this won't return directors
  def get_tomato_movie_by_title(title)
    #uri encoding in ruby http://www.ruby-doc.org/stdlib-2.0.0/libdoc/uri/rdoc/URI/Escape.html
    enc_title = URI.escape(title)
    Film.get('http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=' + ENV['API_KEY'] + '&q=' + enc_title + '&page_limit=1', query: {title: title})
  end

  private
    def default_values
      self.title ||= ""
      self.director ||= ""
      self.tomatoes_id ||= 0
      self.bechdel_rating ||= 0
    end


end
