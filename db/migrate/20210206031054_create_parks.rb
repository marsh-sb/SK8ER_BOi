class CreateParks < ActiveRecord::Migration[5.2]
  def change
    create_table :parks do |t|
      t.integer "user_id"
      t.string "park_image_id"
      t.text "parkname"
      t.text "parkbody"
      t.string "address"
      t.float "latitude"
      t.float "longitude"

      t.timestamps
    end
  end
end
