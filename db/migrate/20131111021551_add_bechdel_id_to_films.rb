class AddBechdelIdToFilms < ActiveRecord::Migration
  def change
    add_column :films, :bechdel_id, :integer
  end
end
