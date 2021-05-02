class Search < ApplicationRecord
	validates :word, presence: { message: "A search word is required" }
	validates :start_url, presence: { message: "A start url is required" }
	
	belongs_to :user
end
