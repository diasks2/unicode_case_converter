require 'csv'

file_location = '/Users/diasks2/Desktop/UnicodeData.txt'
csv_text = File.read(file_location)
csv = CSV.parse(csv_text, col_sep: ";")
uppercase = ''
lowercase = ''
csv.each_with_index do |row, index|
  next if row[-1].nil?
  lowercase = lowercase + "u{" + row[0] + "}"
  uppercase = uppercase + "u{" + row[-1] + "}"
end
puts "Lowercase: #{lowercase}"
puts "Uppercase: #{uppercase}"
