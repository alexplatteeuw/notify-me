class CreateEpisodes < ActiveRecord::Migration[6.1]
  def change
    create_table :episodes do |t|
      t.references :season, null: false, foreign_key: true
      t.date :air_date
      t.integer :episode_number
      t.string :name
      t.integer :season_number
      t.float :vote_average
      t.text :overview
      t.integer :tmdb_id
      t.string :still_path

      t.timestamps
    end
    add_index :episodes, :tmdb_id, unique: true
  end
end
