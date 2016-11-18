class PicturesController < ApplicationController

def index
  @pictures = Picture.all
end

def new
end

def create
  Picture.create(picture: params[:picture], season: params[:season], month: params[:month], time: params[:time], comment: params[:comment], theme:params[:theme],user_id: current_user.id)
end

def show
  @picture = Picture.find(params[:id])
end

end
