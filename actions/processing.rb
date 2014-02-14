Actions.load_action 'main_stem_words'

def processing(sketch)
  path = File.expand_path "../../processing/#{sketch}", __FILE__
  puts "processing #{path}"
  system 'vendor/processing/processing-java',
    "--sketch=#{path}",
    "--output=#{path}/build-tmp",
    "--run",
    "--force"
end

processing 'wordcram'

# bin/run processing /media/niklas/Spinn/Archive/karl_hecht/Werke/Schlafprofile/*
