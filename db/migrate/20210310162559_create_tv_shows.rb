class CreateTvShows < ActiveRecord::Migration[6.1]
  def change
    create_table :tv_shows do |t|
      t.string :backdrop_path
      t.integer :episode_run_time
      t.date :first_air_date
      t.string :name
      t.integer :number_of_seasons
      t.text :overview
      t.string :poster_path
      t.string :status
      t.text :tagline
      t.integer :tmdb_id, unique: true
      t.references :user, null: false, foreign_key: true
      t.float :vote_average

      t.timestamps
    end
    add_index :tv_shows, :tmdb_id, unique: true
  end
end
