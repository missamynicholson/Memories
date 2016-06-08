require 'net/http'
require 'uri'
require 'json'
require 'search.rb'

class MemesController < ApplicationController

	include MemesHelper

	before_action :authenticate_user!, except: [:index]

	def index
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
		meme = Meme.new(raw_image_url: params[:image_ref])
		if meme.save
			flash[:notice]='Image added to meme'
			redirect_to edit_meme_path(meme.id)
		else
			flash[:alert]=meme.errors
			redirect_to request.referer
		end
	end

	def edit
		@meme = Meme.find(params[:id])
	end

	def update
		meme = Meme.find(params[:id])
		public_id = Cloudinary::Uploader.upload(meme.raw_image_url)["public_id"]
		top = url_convert(params[:meme][:top_caption])
		bottom = url_convert(params[:meme][:bottom_caption])

		@transformed_url = Cloudinary::Uploader.upload(Cloudinary::Utils.cloudinary_url(public_id, :transformation => [
 				{:overlay => "text:helvetica_40_bold:#{top}", 
  			:gravity => :north }, {:overlay => "text:helvetica_40_bold:#{bottom}", :gravity => :south }] ))["url"]

	end

end
