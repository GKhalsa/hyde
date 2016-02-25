require 'kramdown'
require 'pry'
require 'fileutils'
require 'erb'
require 'middleman'

class Output
  def build(file_path)
    unless File.directory?("#{file_path}/output/pages")
      build_output_tree(file_path)
    end
    build_html_files(file_path)
    copy_non_markdown_files(file_path)
  end

  def push_to_github_pages(file_path)
    `#{file_path}/output/ git add . `
    `#{file_path}/output/ git commit -m 'auto-push'`
    `#{file_path}/output/ git push -u origin master`
  end

  def build_output_tree(file_path)
    %w(css pages posts media).each do |dir|
      Dir.mkdir("#{file_path}/output/#{dir}")
    end
    %w(index.html pages/about.html posts/welcome_to_hyde.html).each do |dir|
      File.new("#{file_path}/output/#{dir}", "w+")
    end
  end

  def copy_non_markdown_files(file_path)
    Dir.glob("#{file_path}/source/**/*/*[^.md][^.erb]") do |file|
       path_to_output_folder = file.gsub(/source/, "output")
       FileUtils.cp(file, path_to_output_folder)
      end
  end

  def build_html_files(file_path)
    Dir.glob("#{file_path}/**/*.md") do |md_file_path|
      html_body = convert_html_from_markdown(md_file_path)
      contents = render_html_with_template(file_path, html_body)
      html_file_path = md_file_path.gsub(/.md/, ".html").sub(/source/, "output")
      File.write(html_file_path, contents)
    end
  end

  def render_html_with_template(file_path, html_body)
    erb_template = File.read("#{file_path}/source/layouts/default.html.erb")
    ERB.new(erb_template).result(binding)
  end

  # def convert_sass_to_css(file_path)
  #     Dir.glob("#{file_path}/**/*.sass") do |sass_file_path|
  #       sass_text = File.read(sass_file_path)
  #       Sass::CSS.new(sass_text).to_css
  #       css.file_path = sass_file_path.gsub(/.sass/, ".css").sub(/source/, "output").sub(/sass/, "css")
  #       File.write(css.file_path, sass_text)
  # end


  def convert_html_from_markdown(file_path)
    markdown_text = File.read(file_path)
    Kramdown::Document.new(markdown_text).to_html
  end

end
