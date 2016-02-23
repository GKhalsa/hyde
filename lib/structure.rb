class Structure

  def create_tree(file_path)
    if Dir.exist?("#{file_path}")
      raise ArgumentError.new("this path already exists!")
    else
      Dir.mkdir("#{file_path}")
      create_dirs(file_path)
      create_files(file_path)
    end
  end

  

  def create_dirs(file_path)
    Dir.mkdir("#{file_path}/output")
    Dir.mkdir("#{file_path}/source")
    Dir.mkdir("#{file_path}/source/css")
    Dir.mkdir("#{file_path}/source/pages")
    Dir.mkdir("#{file_path}/source/posts")
  end

  def create_files(file_path)
    File.new("#{file_path}/source/css/main.css", "w+")
    File.new("#{file_path}/source/index.md", "w+")
    File.new("#{file_path}/source/about.md", "w+")
    File.new("#{file_path}/source/posts/welcome_to_hyde.md", "w+")
  end

end