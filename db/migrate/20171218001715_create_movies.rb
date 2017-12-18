class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :place
      t.text :description
      t.string :image_url
      t.string :detail_url

      t.timestamps null: false
    end
  end
end
