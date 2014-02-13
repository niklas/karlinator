Actions.load_action 'texts'
require 'lingua/stemmer'

word_count = Hash.new { |h,k| h[k] = 0 }

stemmer = Lingua::Stemmer.new(:language => "de", :encoding => "UTF-8")

@texts.each do |text|
  text.scan(/\p{Letter}+/i) do |word|
    if word.length > 2
      word_count[stemmer.stem(word)] += 1
    end
  end
end

sorted = word_count.sort_by { |word, count| count }

sorted.last(23).reverse.each do |word, count|
  puts "%7d %s" % [count, word]
end
