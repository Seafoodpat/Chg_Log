class Log < ActiveRecord::Base
	belongs_to :user

	validates :amount, numericality: true

	audited

	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (3..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
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
