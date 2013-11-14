namespace :movies do
  desc "Imports all movies from APIs to database"
  task import_from_apis: :environment do
  	Film.create_bechdel_movies
  	Film.add_bechdel_ratings
  	Film.correct_imdb_ids
  	Film.add_tomatoes_movies
  end

  desc "Adds data from Rotten Tomatoes"
  task add_tomatoes: :environment do
  	Film.add_tomatoes_movies
  end

end
