require 'net/http'
require 'uri'
require 'json'
require 'search.rb'

class MemesController < ApplicationController

	include MemesHelper

	before_action :authenticate_user!, except: [:index]
	before_action :set_meme, only: [:edit, :update, :destroy]
	before_action :owned_meme, only: :destroy

	def index
		@memes = Meme.all.order('created_at DESC')
	end

	def get_images
		search = url_convert(params[:search])
		response = getty_request(search)
		Search.current=(response)
		redirect_to request.referer
	end

	def new
		@images = Search.current
	end

	def create
		@meme = current_user.memes.build(raw_image_url: image_params[:image_ref])
		if @meme.save
			flash[:notice]='Image added to meme'
			redirect_to edit_meme_path(@meme.id)
		else
			flash[:alert]= "Uh oh! Couldn't create your meme!"
			redirect_to request.referer
		end
	end

	def edit
		@meme
	end

	def update
		transform_info = transform_image(@meme, meme_params)
		transformed_url = upload_image(transform_info)["url"]
		@meme.memeify(transformed_url)
		flash[:notice]= "Woohoo! Meme added"
		redirect_to memes_path
	end

	def destroy
		if @meme.destroy
      flash[:notice] = "Your meme was successfully deleted!"
      redirect_to memes_path
    else
      flash[:alert] = "Uh oh! Couldn't delete your meme!"
      redirect_to memes_path
    end
	end

	private
	def meme_params
		params.require(:meme).permit(:top_caption, :bottom_caption)
	end

	def image_params
		params.permit(:image_ref)
	end

	def owned_meme
    unless @meme.user == current_user
      flash[:alert] = "That meme doesn't belong to you!"
      redirect_to root_path
    end
  end

	def set_meme
    @meme = Meme.find(params[:id])
  end

end
