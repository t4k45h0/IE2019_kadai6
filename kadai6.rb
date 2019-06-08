require 'csv'

file = ARGV[0] # コマンドライン引数

if file.nil? then
  puts "Enter a filename of pgm."
  file = STDIN.gets.chomp
end

if File.extname(file) != ".pgm" then
  puts "The file extension is not PGM."
  exit!
end

filename = File.basename(file, ".*")

begin
  data = ""
  File.open(file, "rb") do |temp|
    data = temp.read
  end
  data = data.split(/\R/)
rescue
  puts "Error: File not found."
  exit!
end

identifier = data[0]
puts "Type: " + identifier

size_x, size_y = data[1].split
puts "Size x: " + size_x + ", y: " + size_y

brightness = data[2]
puts "Maximum brightness value: " + brightness

puts "Begin the process..."
data = data[3].unpack("C*")
CSV.open("#{filename}.csv", 'wb') do |csv|
  bins = Array.new(2)
  for i in 0..brightness.to_i do
    bins[0] = i
    bins[1] = data.count(i)
    csv << bins
  end
end
puts "Done!"

# Rubyで文字列と数値を相互に変換するメソッドとかのまとめ https://gist.github.com/masquaremo/5114411
