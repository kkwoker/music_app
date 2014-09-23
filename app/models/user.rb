class User < ActiveRecord::Base

	validates :username, presence: true, uniqueness: true
	has_many :reviews	
end