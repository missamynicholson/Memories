class Meme < ActiveRecord::Base

  belongs_to :user

	validates :raw_image_url, presence: true
  

end
