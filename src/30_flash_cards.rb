#!/usr/bin/env ruby

unless ARGV[0]
  puts "\n\nUsage is flashCards.rb <file>\n\n"
  exit
end

flash = []

Card = Struct.new(:question, :answer)

File.open(ARGV[0], "rb").each do |line|
  if line =~ /(.*)\s{3,10}(.*)/
    flash << Card.new($1.strip, $2.strip)
  end
end

flash.replace(flash.sort_by { rand })

until flash.empty?
  card = flash.pop
  print "Question: #{card.question}? "
  guess = $stdin.gets.chomp

  if guess.downcase == card.answer.downcase
    puts "\n\nCORRECT: The answer is #{card.answer}\n\n"
  else
    puts "\n\nWRONG: The answer is #{card.answer}\n\n"
  end
end



