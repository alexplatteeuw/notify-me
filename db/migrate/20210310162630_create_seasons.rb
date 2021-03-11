class CreateSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :seasons do |t|
      t.references :tv_show, null: false, foreign_key: true
      t.integer :tmdb_id
      t.date :air_date
      t.integer :season_number
      t.string :name
      t.text :overview
      t.string :still_path
      t.float :vote_average
      t.integer :episode_count
      t.timestamps
    end
    add_index :seasons, :tmdb_id, unique: true
  end
end
