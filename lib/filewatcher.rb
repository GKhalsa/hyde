require 'filewatcher'
class Filewatcher

  def watch_file(file_path)
    FileWatcher.new(["#{file_path}"]).watch() do |filename, event|
      if(event == :changed)
        `bin/hyde build file_path`
        puts "Your build has been updated"
      end
      if(event == :delete)
        `bin/hyde build file_path`
        puts "Your build has been updated" #+ filename
      end
      if(event == :new)
        `bin/hyde build file_path`
        puts "Your build has been updated" #+ filename
      end
    end
  end
end
