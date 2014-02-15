Actions.load_action 'texts'

require 'marky_markov'
markov = MarkyMarkov::TemporaryDictionary.new 2

@texts.each do |text|
  markov.parse_string text
end

def ask(question='')
  puts
  puts question unless question.empty?
  print "Karl-inator> "
  STDIN.gets.chomp
end

while line = ask do
  case line
  when /^[qe]/
    exit
  when 'debug'
    require 'pry'
    binding.pry
  when /\A\d+\z/
    puts markov.generate_n_sentences line.to_i
  else
    puts markov.generate_n_sentences 1
  end
end
