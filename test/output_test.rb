require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/structure'
require_relative '../lib/output'
require 'fileutils'
require 'pry'

class OutputTest < Minitest::Test

  attr_reader :output,
              :structure,
              :test_path,
              :file_path

  def setup
    @output = Output.new
    @structure = Structure.new
    @test_path = File.expand_path(__dir__)
    @file_path = "#{test_path}/test_files"
  end

  def test_writing_and_reading_functionality
    if Dir.exist?(file_path)
      FileUtils.remove_dir(file_path)
    end
    structure.create_tree(file_path)
    output.build_output_tree(file_path)
    text = "# Some Markdown*"
    File.write("#{file_path}/source/about.md", text)
    assert text, File.read("#{file_path}/source/about.md")
  end

  def test_convert_html_takes_markdown_files_in_source_and_coverts_them_to_html
    if Dir.exist?(file_path)
      FileUtils.remove_dir(file_path)
    end
    structure.create_tree(file_path)
    output.build_output_tree(file_path)
    text = "# Some Markdown*"
    File.write("#{file_path}/source/about.md", text)
     assert_equal "<h1 id=\"some-markdown\">Some Markdown*</h1>
", output.convert_html_from_markdown("#{file_path}/source/about.md")
  end

  def test_builds_output_structure
    if Dir.exist?(file_path)
      FileUtils.remove_dir(file_path)
    end
    structure.create_tree(file_path)
    output.build_output_tree(file_path)

    assert Dir.exist?("#{file_path}/output")
    assert Dir.exist?("#{file_path}/output/css")
    assert Dir.exist?("#{file_path}/output/pages")
    assert Dir.exist?("#{file_path}/output/posts")


    assert File.exist?("#{file_path}/output/index.html")
    assert File.exist?("#{file_path}/output/pages/about.html")
    assert File.exist?("#{file_path}/output/posts/welcome_to_hyde.html")
   end

  def test_takes_markdown_files_converts_to_html_and_writes_to_html_file_in_output
    skip
    if Dir.exist?(file_path)
      FileUtils.remove_dir(file_path)
    end

    structure.create_tree(file_path)
    output.build_output_tree(file_path)
    text = "# Some Markdown*"
    File.write("#{file_path}/source/pages/about.md", text)
    File.write("#{file_path}/source/index.md", text)
    File.write("#{file_path}/source/posts/welcome_to_hyde.md", text)
    output.build_html_files(file_path)

    assert_equal "<h1 id=\"some-markdown\">Some Markdown*</h1>
", File.read("#{file_path}/output/pages/about.html")
    assert_equal "<h1 id=\"some-markdown\">Some Markdown*</h1>
", File.read("#{file_path}/output/index.html")
    assert_equal "<h1 id=\"some-markdown\">Some Markdown*</h1>
", File.read("#{file_path}/output/posts/welcome_to_hyde.html")
  end

  def test_transfering_non_md_files_to_output
    if Dir.exist?(file_path)
      FileUtils.remove_dir(file_path)
    end

    structure.create_tree(file_path)
    output.build_output_tree(file_path)
    output.copy_non_markdown_files(file_path)
    assert File.exist?("#{file_path}/output/css")
  end

  def test_html_is_formatted_with_template_styling_using_ERB
    if Dir.exist?(file_path)
      FileUtils.remove_dir(file_path)
    end

    structure.create_tree(file_path)
    output.build_output_tree(file_path)
    text = "# Some Markdown*"
    File.write("#{file_path}/source/pages/about.md", text)
    output.build_html_files(file_path)
    assert_equal "

<html>

  <head><title>Our Site</title></head>

  <link rel=\"stylesheet\" type =\"text/css\" href=\"../css/main.css\" >

  <body>
    <h1 id=\"some-markdown\">Some Markdown*</h1>

  </body>

</html>
", File.read("#{file_path}/output/pages/about.html")
  end

  def test_sass_is_converted_into_css_ranames_to_css
    if Dir.exist?(file_path)
      FileUtils.remove_dir(file_path)
    end

    structure.create_tree(file_path)
    output.build_output_tree(file_path)
    sass_text = File.read("sasstest.sass")
    css_text = File.read("csstest.css")

    File.write("#{file_path}/source/sass/cool_format.sass", sass_text)

    output.convert_sass_to_css(file_path)
    assert_equal css_text, File.read("#{file_path}/output/css/cool_format.css")
   end

  def test_haml_is_coverted_to_html_when_called
    if Dir.exist?(file_path)
      FileUtils.remove_dir(file_path)
    end

    structure.create_tree(file_path)
    output.build_output_tree(file_path)
    haml_text = File.read("hamltest.haml")
    http_text = File.read("htmltest.html")

    File.write("#{file_path}/source/sass/cool_format.sass", sass_text)

    output.convert_sass_to_css(file_path)
    assert_equal css_text, File.read("#{file_path}/output/css/cool_format.css")

end
