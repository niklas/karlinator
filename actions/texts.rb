Actions.load_action 'files'

require 'yomu'
require 'ruby-progressbar'

def texts
  if defined?(@texts)
    @texts.each { |t| yield t }
  else
    Actions.progressbar "Extrahiere Text", @files.count do |progress|
      @texts = @files.map do |file|
        begin
          progress.title = "%23s" % File.basename(file)
          yomu = Yomu.new file
          yield(yomu.text.tap do
            progress.increment
          end)
        rescue
        end
      end.flatten.reject(&:nil?).reject(&:empty?)
    end
  end
end

