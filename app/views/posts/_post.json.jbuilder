json.extract! post, :id, :name, :description, :release_date, :director, :length, :created_at, :updated_at
json.url post_url(post, format: :json)
