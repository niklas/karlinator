Actions.load_action 'texts'
require 'lingua/stemmer'

word_count = Hash.new { |h,k| h[k] = 0 }

stop_words = File.read('db/stop_words_de.txt').scan(/\p{Letter}+/i)
stop_words += File.read('db/stop_words_en.txt').scan(/\p{Letter}+/i)
stemmer = Lingua::Stemmer.new(:language => "de", :encoding => "UTF-8")

@texts.each do |text|
  text.scan(/\p{Letter}+/i) do |word|
    word = word.downcase
    if word.length > 2 and !stop_words.include?(word)
      word_count[stemmer.stem(word)] += 1
    end
  end
end

sorted = word_count.sort_by { |word, count| count }

write 'word_count' do |f|
  sorted.last(1000).reverse.each do |word, count|
    if count > 1
      f.word word, count
    end
  end
end unless sorted.empty?

