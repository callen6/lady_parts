class AddDpmToFilms < ActiveRecord::Migration
  def change
    add_column :films, :dpm, :integer
  end
end
