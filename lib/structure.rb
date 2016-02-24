require 'fileutils'

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
    %w(output source).each do |dir|
      Dir.mkdir("#{file_path}/#{dir}")
    end
    %w(css pages posts media layouts).each do |dir|
      Dir.mkdir("#{file_path}/source/#{dir}")
    end
  end

  def create_files(file_path)
    %w(css/main.css index.md pages/about.md posts/welcome_to_hyde.md).each do |dir|
      File.new("#{file_path}/source/#{dir}", "w+")
    end
    FileUtils.cp_r(Dir.glob("../**/lib/*.erb"),"#{file_path}/source/layouts")
  end


  def create_post(file_path, post_title)
    File.new("#{file_path}/source/posts/#{post_title.join("_").downcase}.md", "w+")
    create_post_content(file_path, post_title)
  end

  def create_post_content(file_path, post_title)
    contents = "# *#{post_title.join(" ")}*\n\nYour content here"
    File.write("#{file_path}/source/posts/#{post_title.join("_")}.md", contents)
  end
end
