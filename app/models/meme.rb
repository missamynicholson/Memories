class Meme < ActiveRecord::Base

	validates :raw_image_url, presence: true

end
