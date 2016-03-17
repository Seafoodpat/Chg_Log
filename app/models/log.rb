class Log < ActiveRecord::Base
	belongs_to :user

	validates :amount, numericality: true

	audited

end
