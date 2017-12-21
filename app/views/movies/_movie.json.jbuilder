json.extract! movie, :id, :title, :place, :description, :image_url, :detail_url, :created_at, :updated_at
json.url movie_url(movie, format: :json)
