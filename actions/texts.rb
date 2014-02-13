Actions.load_action 'files'

require 'yomu'
@texts = @files.map do |file|
  yomu = Yomu.new file
  yomu.text
end
