# require 'bcrypt'

class User < ApplicationRecord
	# include BCrypt

	has_secure_password
	validates :name, presence: { message: "Name is required" }, length: { in: 5..50, message: "Name length must not outlimit [5-50] characters" }, format: { with: /\A[A-Za-z][A-Za-z\'\-]+([\ A-Za-z][A-Za-z\'\-]+)*/, message: "Invalid name. You can only use alphabets, numbers, . and _" }
	validates :username, presence: { message: "Username is required" }, uniqueness: {message: "Username already used."}, length: { in: 5..50, message: "Username length must not outlimit [5-50] characters" }, format: { with: /\A(?=.{5,50}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])\z/, message: "Invalid username. You can only use alphabets, numbers, . and _" }
	# 	/\A(?=.{5,50}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])\z/
	#    └─────┬────┘└───┬──┘└─────┬─────┘└─────┬─────┘ └───┬───┘
	#          │         │         │            │           no _ or . at the end
	#          │         │         │            │
	#          │         │         │            allowed characters
	#          │         │         │
	#          │         │         no __ or _. or ._ or .. inside
	#          │         │
	#          │         no _ or . at the beginning
	#          │
	#          username is 5-20 characters long
  validates :password, presence: true, length: { in: 8..50 }
end
