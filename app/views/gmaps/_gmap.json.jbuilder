json.extract! gmap, :id, :title, :description, :address, :latitude, :longitude, :created_at, :updated_at
json.url gmap_url(gmap, format: :json)