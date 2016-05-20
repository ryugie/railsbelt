class Borrower < ActiveRecord::Base

	has_secure_password
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	has_many :histories
	has_many :lenders, :through => :histories

	validates :password, presence: true, on: :create
	validates :first_name, :last_name, presence: true, length: { in: 2..20 }
	validates :purpose, :description, presence: true
	# validates :raised
	validates :money, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
	validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	
	before_save do
  		self.email.downcase!
  	end
end
