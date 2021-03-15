class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.integer :tmdb_id, null: false, unique: true
      t.string :name
      t.string :known_for_department
      t.float :popularity
      t.string :profile_path
      t.string :job
      t.references :tv_show, null: false, foreign_key: true

      t.timestamps
    end
    add_index :people, :tmdb_id, unique: true
  end
end
