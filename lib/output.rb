require 'kramdown'
require 'pry'
require 'fileutils'

class Output

  def build(file_path)
    unless File.directory?("#{file_path}/output/pages")
      build_output_tree(file_path)
    end
    build_html(file_path)
    copy_files(file_path)
  end

  def build_output_tree(file_path)
    Dir.mkdir("#{file_path}/output/css")
    Dir.mkdir("#{file_path}/output/pages")
    Dir.mkdir("#{file_path}/output/posts")
    Dir.mkdir("#{file_path}/output/media")
    File.new("#{file_path}/output/index.html", "w+")
    File.new("#{file_path}/output/pages/about.html", "w+")
    File.new("#{file_path}/output/posts/welcome_to_hyde.html", "w+")
  end

  def copy_files(file_path)
    Dir.glob("#{file_path}/source/**/*/*[^.md]") do |other_file|
       other_path = other_file.gsub(/source/, "output")
       FileUtils.cp(other_file, other_path)
      end
  end

  def build_html(file_path)
     Dir.glob("#{file_path}/**/*.md") do |md_file|
      html = convert_html(md_file)
      md_file_html = md_file.gsub(/.md/, ".html").gsub(/source/, "output")
      File.write(md_file_html, html)
    end
  end

  def convert_html(file_path)
    markdown_text = File.read(file_path)
    html_text = Kramdown::Document.new(markdown_text).to_html
  end

end
