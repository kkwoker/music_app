class Review < ActiveRecord::Base

	belongs_to :user
	belongs_to :track

	validates_uniqueness_of :user_id, :scope => :track_id 

end