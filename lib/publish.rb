module Publish

  def publish_to_git_page(file_path)
    if File.exists?("#{file_path}/../index.html")
       File.delete("#{file_path}/../index.html")
    end
    copy_index = "cd #{file_path}/output && cp index.html #{file_path}/.. "
    move_to_proper_dir = "&& cd #{file_path}/.. && git add . "
    commit = "&& git commit -m 'updated' && git push origin master"
    `#{copy_index}#{move_to_proper_dir}#{commit}`
  end

end
