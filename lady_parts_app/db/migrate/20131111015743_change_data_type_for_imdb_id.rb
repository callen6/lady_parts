class ChangeDataTypeForImdbId < ActiveRecord::Migration
  def change
  	def self.up
    change_table :films do |t|
      t.change :imdb_id, :string
    end
  end
  def self.down
    change_table :films do |t|
      t.change :imdb_id, :integer
    end
  end
  end
end
