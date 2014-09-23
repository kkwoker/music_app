class CreateUpvote < ActiveRecord::Migration
  def change
  	create_table :upvotes do |t|
  		t.string :user_id
  		t.string :track_id
  		
  	end
  end
end
