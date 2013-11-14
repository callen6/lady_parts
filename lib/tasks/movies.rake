namespace :movies do

	# Can be run with:
	# `rake movies:import_from_apis` - local
	# `heroku run movies:import_from_apis` - on heroku
  desc "Imports all movies from APIs to database"
  task import_from_apis: :environment do
  	Film.create_bechdel_movies
  	Film.add_bechdel_ratings
  	Film.correct_imdb_ids
  	Film.add_tomatoes_movies
  end

  # Can be run with: 
	# `rake movies:add_tomatoes` - local
	# `heroku run movies:add_tomatoes` - on heroku
  desc "Adds data from Rotten Tomatoes"
  task add_tomatoes: :environment do
  	Film.add_tomatoes_movies
  end

end
