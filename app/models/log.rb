class Log < ActiveRecord::Base
	belongs_to :user

	validates :amount, numericality: true

	audited

MAPPING = {
	"Record ID" => "id",
	"Chq Number" => "chq_number",
	"Chq Date" => "chq_date",
	"Payee Name" => "payee_name",
	"Category" => "category",
	"Deal ID" => "deal_id",
	"Particular" => "particular",
	"Salesperson" => "salesperson",
	"Voucher Number" => "voucher_no",
	"Currencies" => "currencies",
	"Amount" => "amount",
	"Prepared by" => "prepared",
	"Signed Chq Date" => "sign_date",
	"Chq Presented Date" => "present_date",
	"Void Chq Reason" => "void_reason"
}

	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    row.keys.each { |k| row[ MAPPING[k] ] = row.delete(k) if MAPPING[k] }
	    log = find_by_id(row["id"]) || new
	    log.attributes = row.to_hash.slice(*row.to_hash.keys)
	    log.save!
	  end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
	  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
	  when ".xlsx" then Roo::Excelx.new(file.path, packed: false, file_warning: :ignore)
	  else raise "Unknown file type: #{file.original_filename}"
	  end
	end


end


