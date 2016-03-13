class Log < ActiveRecord::Base
	belongs_to :user

	validates :amount, numericality: true

	audited



	def self.to_csv
    attributes = %w{chq_number chq_date payee_name category deal_id particular salesperson voucher_no currencies amount prepared sign_date present_date}

    CSV.generate(:col_sep => ("|"), headers: true) do |csv|
      csv << attributes

      all.each do |log|
        csv << attributes.map{ |attr| log.send(attr) }
      end
    end
  end
end
