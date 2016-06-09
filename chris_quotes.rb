require 'rubygems'
require 'active_support'
require "Nokogiri"
require "open-uri"


class Quote
  attr_accessor :author, :index
  attr_reader :document, :quotes

  def initialize(author='hitchens')
    @author   = author
    @document = Nokogiri::HTML(open endpoints[@author])
    @quotes   = @document.css('blockquote')
    @index    = rand(@quotes&.count - 1)
  end

  def get
    quote = quotes[index]

    if quote
      puts ""
      puts success_message
      quote.content
    else
      find_quote!
    end
  end

  def find_quote!
    quote = nil

    while quote.nil? || index > 0
      if quote = document[index]
        puts success_message
        quote.content
      else
        self.index -= 1
      end
    end
  end

  def endpoints
    {
      'hitchens' => 'http://www.patheos.com/blogs/unreasonablefaith/2011/12/the-20-best-christopher-hitchens-quotes/',
      'einstein' => 'http://rescomp.stanford.edu/~cheshire/EinsteinQuotes.html'
    }
  end

  private

  def success_message
    "Your #{author.capitalize} quote of the day."
  end
end

quote = Quote.new.get

puts "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n\n"
br = 8
words = quote.to_s.split(" ")
words = words.map do |word|
  if words.index(word) >= br
    br += 8
    "#{word}\n\n"
  else
    word
  end
end

puts " " + words.join(" ")
