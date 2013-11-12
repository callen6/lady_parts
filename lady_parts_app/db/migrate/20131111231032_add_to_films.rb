class AddToFilms < ActiveRecord::Migration
  def change
  	add_column :films, :year, :integer
  	add_column :films, :critics_score, :integer
  	add_column :films, :audience_score, :integer
  	add_column :films, :poster, :text
  	add_column :films, :studio, :string
  	add_column :films, :cast, :string, array: true, default: []
  end
end
