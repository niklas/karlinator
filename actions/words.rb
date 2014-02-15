Actions.load_action 'texts'

word_count = Hash.new { |h,k| h[k] = 0 }

texts do |text|
  text.scan(/\p{Letter}+/i) do |word|
    if word.length > 2
      word_count[word] += 1
    end
  end
end

sorted = word_count.sort_by { |word, count| count }

sorted.last(23).reverse.each do |word, count|
  puts "%7d %s" % [count, word]
end


# bin/run words /media/niklas/Spinn/Archive/karl_hecht/Werke/Schlafprofile/*
