require 'kramdown'
require 'pry'
require 'fileutils'
require 'erb'
require 'sass'
require 'haml'
require_relative 'haml_and_sass_converter'


class Output

  include HamlAndSassConverter

  def build(file_path)
    unless File.directory?("#{file_path}/output/pages")
      build_output_tree(file_path)
    end
    build_html_files(file_path)
    convert_haml_to_html(file_path)
    convert_sass_to_css(file_path)
    copy_non_markdown_files(file_path)
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
    non_markdown_file_pathway = "/source/**/*/*[^.md][^.erb][^.sass][^.haml]"
    Dir.glob("#{file_path}#{non_markdown_file_pathway}") do |file|
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

  def convert_html_from_markdown(file_path)
    markdown_text = File.read(file_path)
    Kramdown::Document.new(markdown_text).to_html
  end


end
