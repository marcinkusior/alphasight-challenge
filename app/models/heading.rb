class Heading < ActiveRecord::Base

	validates :group, presence: true
	validates :content, presence: true
	validates :user_id, presence: true

	belongs_to :user

	def self.search(query)
		Heading.where("content like ?", "%#{query}%")
	end
end

