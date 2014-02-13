Actions.load_action 'files'

require 'yomu'
require 'ruby-progressbar'

Actions.progressbar "Extrahiere Text", @files.count do |progress|
  @texts = @files.map do |file|
    yomu = Yomu.new file
    yomu.text.tap do
      progress.increment
    end
  end
end
