Actions.load_action 'files'

require 'yomu'
require 'ruby-progressbar'

Actions.progressbar "Extrahiere Text", @files.count do |progress|
  @texts = @files.map do |file|
    begin
      progress.title = "%23s" % File.basename(file)
      yomu = Yomu.new file
      yomu.text.tap do
        progress.increment
      end
    rescue
    end
  end.flatten.reject(&:nil?).reject(&:empty?)
end
