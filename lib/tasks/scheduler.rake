desc "This task is removing the tv shows that aren't favorited from the db"
task :clean_tv_shows => :environment do
  puts "Cleaning TV Shows"
  ids = TvShow.pluck(:id) - Favorite.favorite_list.pluck(:favoritable_id)
  TvShow.destroy(ids)
  puts "done."
end
