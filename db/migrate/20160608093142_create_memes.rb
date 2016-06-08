class CreateMemes < ActiveRecord::Migration
  def change
    create_table :memes do |t|
      t.string :raw_image_url
      t.string :top_caption
      t.string :bottom_caption

      t.timestamps null: false
    end
  end
end
