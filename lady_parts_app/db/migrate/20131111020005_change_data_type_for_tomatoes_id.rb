class ChangeDataTypeForTomatoesId < ActiveRecord::Migration
  def change
  def self.up
    change_table :films do |t|
      t.change :tomatoes_id, :string
    end
  end
  def self.down
    change_table :films do |t|
      t.change :tomatoes_id, :integer
    end
  end
  end
end
