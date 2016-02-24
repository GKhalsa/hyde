require 'kramdown'

class Output

  def build_output_tree(file_path)
    Dir.mkdir("#{file_path}/output/css")
    Dir.mkdir("#{file_path}/output/pages")
    Dir.mkdir("#{file_path}/output/posts")
    File.new("#{file_path}/output/css/main.css", "w+")
    File.new("#{file_path}/output/index.html", "w+")
    File.new("#{file_path}/output/about.html", "w+")
    File.new("#{file_path}/output/posts/welcome_to_hyde.html", "w+")
  end

  

  def convert_html(file_path)
    markdown_text = File.read(file_path)
    html_text = Kramdown::Document.new(markdown_text).to_html
  end

end
