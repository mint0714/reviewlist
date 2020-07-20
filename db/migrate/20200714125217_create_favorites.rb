class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
      create_table :favorites do |t|
        t.references :user, foreign_key: true, nul: false
        t.references :vote, nul: false
        t.timestamps
        
        t.index [:user_id, :vote_id], unique: true
        
      end
      add_foreign_key :favorites, :reviews, column: :vote_id, primary_key: :vote_id
  end
end
