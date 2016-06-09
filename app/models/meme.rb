class Meme < ActiveRecord::Base

  belongs_to :user

	validates :raw_image_url, presence: true
	has_attached_file :image, styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>" }
	validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}


	def memeify(transformed_url)
		self.image = URI.parse(transformed_url)
		self.save
	end
end
