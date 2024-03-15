json.extract! film, :id, :name, :description, :release_date, :director, :length, :created_at, :updated_at
json.url film_url(film, format: :json)
