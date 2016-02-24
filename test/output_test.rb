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
", output.convert_html("#{file_path}/source/about.md")
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

    assert File.exist?("#{file_path}/output/css/main.css")
    assert File.exist?("#{file_path}/output/index.html")
    assert File.exist?("#{file_path}/output/about.html")
    assert File.exist?("#{file_path}/output/posts/welcome_to_hyde.html")
   end

  def test_takes_markdown_files_converts_to_html_and_writes_to_html_file_in_output
    if Dir.exist?(file_path)
      FileUtils.remove_dir(file_path)
    end
    structure.create_tree(file_path)
    text = "# Some Markdown*"
    File.write("#{file_path}/source/about.md", text)
    output.build_output_tree(file_path)
    output.build_html(file_path)
    assert_equal "ba", File.read("#{file_path}/output/about.html")
  end



end
#build_output => build output dirs and files/folders
