class Film < ActiveRecord::Base
  include HTTParty
  default_params output: 'json'
  format :json
  before_create :default_values

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
      movie.tomatoes_id = tomato_movie["id"] || "0"
      # movie.director = tomato_movie["abridged_directors"][0]["name"] || "No record in Rotten Tomatoes"
      movie.year = tomato_movie["year"] || 0 # integer
      movie.critics_score = tomato_movie["ratings"]["critics_score"] || 0 # integer
      movie.audience_score = tomato_movie["ratings"]["audience_score"] || 0 # integer
      movie.poster = tomato_movie["posters"]["detailed"] || "No Record in Rotten Tomatoes"
      movie.studio = tomato_movie["studio"] || "No Record in Rotten Tomatoes"
      movie.cast = tomato_movie["abridged_cast"].map{|u| [u["name"], u["id"]] } || "No Record in Rotten Tomatoes" # array of names
      movie.save
    end
  end

  # Bechdel Test API methods using HTTParty

  def self.get_all_movie_ids # class method on Film
    all_bechdel_films = get('http://bechdeltest.com/api/v1/getAllMovieIds')
  end

  def get_movie_by_imdb_id(imdb_id)
    Film.get('http://bechdeltest.com/api/v1/getMovieByImdbId', query: {imdbid: imdb_id})
  end

  def get_movies_by_title(title) 
    Film.get('http://bechdeltest.com/api/v1/getMoviesByTitle', query: {title: title})
  end

  # Rotten Tomatoes API methods using HTTParty

  def get_tomato_movie_by_imdb_id(imdb_id) # if we take away self, we have to put in Film
     Film.get('http://api.rottentomatoes.com/api/public/v1.0/movie_alias.json?apikey=' + ENV['API_KEY'] + '&type=imdb&id=' + imdb_id, query: {imdb_id: imdb_id})
  end

  def get_tomato_movie_by_title(title) # this won't return directors
    #uri encoding in ruby http://www.ruby-doc.org/stdlib-2.0.0/libdoc/uri/rdoc/URI/Escape.html
    enc_title = URI.escape(title)
    Film.get('http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=' + ENV['API_KEY'] + '&q=' + enc_title + '&page_limit=1', query: {title: title})
  end

end
