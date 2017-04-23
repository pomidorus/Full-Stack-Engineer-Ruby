class CreateComics < ActiveRecord::Migration[5.0]
  def change
    create_table :comics do |t|
      t.integer :comic_id
      t.string  :title
      t.integer :year
      t.integer :issue_number
      t.string  :thumbnail_url
      t.string  :characters

      t.timestamps
    end

    add_index :comics, :year
    add_index :comics, :issue_number
  end
end
