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

def self.add_bechdel_ratings
  movies = Film.all
  movies.each do |movie|
    imdb = movie.imdb_id
    bechdel_movie = movie.get_movie_by_imdb_id(imdb)
    movie.bechdel_rating = bechdel_movie['rating']
    movie.save
  end
end

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
    end
  end
end

def self.add_tomatoes_movies
  movies = Film.all
  movies.each do |movie|
    tomato_movie = movie.get_tomato_movie_by_imdb_id(movie.imdb_id.to_s)
        movie.title = tomato_movie["title"] || "No record in Rotten Tomatoes" 
          # movie.director = tomato_movie["abridged_directors"][0]["name"] || "No record in Rotten Tomatoes" 
          movie.tomatoes_id = tomato_movie["id"] || "0"
          # movie.year = tomato_movie["year"]
          # movie.critics_score = tomato_movie["ratings"]["critics_score"]
          # movie.audience_score = tomato_movie["ratings"]["audience_score"]
          # movie.poster = tomato_movie["posters"]["detailed"]
          # movie.studio = tomato_movie["studio"]
          # movie.cast = tomato_movie["abridged_cast"].map{|u| u["name"]}
          movie.save
        end
      end


 # Bechdel Test API methods using HTTParty

# then, if it doesn't, we can get all the movie id's
# this will only be used the first time, and then again weekly?
  # class method
  def self.get_all_movie_ids
    all_bechdel_films = get('http://bechdeltest.com/api/v1/getAllMovieIds')
  end


  def get_movie_by_imdb_id(imdb_id)
    Film.get('http://bechdeltest.com/api/v1/getMovieByImdbId', query: {imdbid: imdb_id})
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
 end


 def get_tomato_movie_by_imdb_id(imdb_id)
  Film.get('http://api.rottentomatoes.com/api/public/v1.0/movie_alias.json?apikey=' + ENV['API_KEY'] + '&type=imdb&id=' + imdb_id, query: {imdb_id: imdb_id})
end

# this won't return directors
def get_tomato_movie_by_title(title)
    #uri encoding in ruby http://www.ruby-doc.org/stdlib-2.0.0/libdoc/uri/rdoc/URI/Escape.html
    enc_title = URI.escape(title)
    Film.get('http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=' + ENV['API_KEY'] + '&q=' + enc_title + '&page_limit=1', query: {title: title})
  end

  private
    # def default_values
    #   self.title ||= ""
    #   self.director ||= ""
    #   self.tomatoes_id ||= 0
    #   self.bechdel_rating ||= 0
    # end


  end
