
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
