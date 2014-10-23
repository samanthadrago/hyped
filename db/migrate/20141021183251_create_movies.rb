class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :rt_id
      t.string :title
      t.string :rating
      t.string :year
      t.string :img
      t.string :url
      t.string :similar_url
      t.string :summary

      t.timestamps
    end
  end
end
