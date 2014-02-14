require 'find'

files = []

ARGV.each do |arg|
  if File.file?(arg)
    files << arg
  elsif FileTest.directory?(arg)
    Find.find(arg) do |path|
      name = File.basename(path)
      if name[0] == ?.
        Find.prune
      else
        if FileTest.directory?(path)
          next
        else
          if name =~ /(pdf|doc|docx)\Z/i
            files << path
          end
        end
      end
    end
  end
end


@files = files
puts "#{@files.count} Dateien"

# find /media/niklas/Spinn/Archive/karl_hecht/Werke | ruby -n -e 'puts $1 if $_ =~ /\.([^.]+)$/'  | sort | uniq
