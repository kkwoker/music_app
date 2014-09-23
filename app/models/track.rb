class Track < ActiveRecord::Base

	has_many :upvotes
	validates :title, presence: true
	validates :author, presence: true


end