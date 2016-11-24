class PicturesController < ApplicationController

def index
  @pictures = Picture.order("created_at DESC").page(params[:page]).per(15)
  @ranking = Picture.group(:ave_rank).order("ave_rank DESC").limit(3)
end


def new
  @picture = Picture.new
end

def create
  @picture = Picture.create(picture: picture_params[:picture], season: picture_params[:season], month: picture_params[:month], time: picture_params[:time], location: picture_params[:location], theme: picture_params[:theme], comment: picture_params[:comment], user_id: current_user.id)
  binding.pry
   Place.create(name: picture_params[:location],picture_id: @picture.id)


  redirect_to controller: :pictures, action: :index
end



def show
  @picture = Picture.find(params[:id])
  @place = Place.where(picture_id: params[:id])
  @hash = Gmaps4rails.build_markers(@place) do |place, marker|
    marker.lat place.latitude
    marker.lng place.longitude
    marker.infowindow render_to_string(partial: "places/infowindow", locals: { place: place })
  end
end


def destroy
  @picture = Picture.find(params[:id])
  if @picture.user_id == current_user.id
  @picture.destroy
  end
end

def edit
  @picture = Picture.find(params[:id])
end

def update
  picture = Picture.find(params[:id])
  if picture.user_id == current_user.id
  picture.update(season: picture_params[:season],month: picture_params[:month],time: picture_params[:time],location: picture_params[:location],theme: picture_params[:theme],theme: picture_params[:theme])
  end
  redirect_to root_path
end

def search
end

def search_output
 @pictures = Picture.where(season: output_params[:season], time: output_params[:time], theme: output_params[:theme]).order("created_at DESC")
 @ranking = Picture.group(:ave_rank).order("ave_rank DESC").limit(3)
end



private
def picture_params
 params.require(:picture).permit(:picture, :season, :month, :time, :theme, :comment, :location)

end

def output_params
  params.permit(:season, :time, :theme)
end

end


