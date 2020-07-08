class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :image_url
      t.string :menu_name
      t.text :shop_url
      t.string :update_date
      t.string :shop_name
      t.text :comment

      t.timestamps
    end
  end
end
