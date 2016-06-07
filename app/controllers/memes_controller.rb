require 'net/http'
require 'uri'
require 'json'
require 'search.rb'

class MemesController < ApplicationController

	include MemesHelper

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
		# render the images on the page for the user to choose
		# choose image
	end
end
