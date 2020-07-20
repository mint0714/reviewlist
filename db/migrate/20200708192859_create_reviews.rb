class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews,id: false do |t|
      t.string :image_url
      t.string :menu_name
      t.text :shop_url
      t.string :update_date
      t.string :shop_name
      t.text :comment
      t.integer :vote_id, null: false, primary_key: true, limit: 8

      t.timestamps
    end
  end
end
