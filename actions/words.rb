puts "Word list"

files = ARGV

require 'yomu'

count = Hash.new { |h,k| h[k] = 0 }

files.each do |file|
  yomu = Yomu.new file
  text = yomu.text

  text.scan(/\p{Letter}+/i) do |word|
    if word.length > 2
      count[word] += 1
    end
  end
end

sorted = count.sort_by { |word, count| count }

sorted.each do |word, count|
  puts "%7d %s" % [count, word]
end


# bin/run words /media/niklas/Spinn/Archive/karl_hecht/Werke/Schlafprofile/*
