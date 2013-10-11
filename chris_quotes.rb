require 'rubygems'
require 'active_support'
require "Nokogiri"
require "open-uri"

puts "What quote would you prefer Hitchens, Twain, or Einstein?"
answer = gets.chomp 
answer_down = answer.downcase
hitchens = 'http://www.patheos.com/blogs/unreasonablefaith/2011/12/the-20-best-christopher-hitchens-quotes/'
twain = 'http://jpetrie.myweb.uga.edu/clemens.html'
einstein = 'http://rescomp.stanford.edu/~cheshire/EinsteinQuotes.html' 

if answer_down =~ /h.*|i.*/
  doc = Nokogiri::HTML(open(hitchens))
  blockquotes = doc.css('blockquote')
  random_content =  blockquotes[(rand(30))].content
  puts "Your Hitchens quote of the day, god rest his soal:"
elsif answer_down =~ /t.*|w.*/
  doc = Nokogiri::HTML(open(twain))
  p = doc.css('p')
  random_content = p[(rand(30))].content
  puts "Your " +  answer.capitalize + " quote of the day:"
elsif answer_down =~ /e.*|i.*/
  doc = Nokogiri::HTML(open(einstein))
  line = doc.css('li') 
  random_content = line[(rand(30))].content
  puts "Your " +  answer.capitalize + " quote of the day:"
else
  puts " Only three choices for now you quote lush"
end


puts '=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-='
if answer = answer
  puts random_content.to_s.ljust(100)
end
puts '=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-'


