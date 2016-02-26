module Publish

def publish_to_git_page(file_path)
  if File.exists?("#{file_path}/../index.html")
     File.delete("#{file_path}/../index.html")
  end
`cd #{file_path}/output && cp index.html #{file_path}/.. && cd #{file_path}/.. && git add . && git commit -m 'updated' && git push origin master`
end

end
