class AddUpvotedToComics < ActiveRecord::Migration[5.0]
  def change
    add_column :comics, :upvoted, :boolean, default: false
  end
end
