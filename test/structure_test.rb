require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/structure'
require 'fileutils'

class StructureTest < Minitest::Test

  attr_reader :structure,
              :test_path,
              :file_path

  def setup
    @structure = Structure.new
    @test_path = File.expand_path(__dir__)
    @file_path = "#{test_path}/test_files"
  end

  def test_when_new_is_argv0_it_creates_new_file_structure

    if Dir.exist?(file_path)
      FileUtils.remove_dir(file_path)
    end

    structure.create_tree(file_path)
    assert Dir.exist?("#{file_path}/source")
    assert Dir.exist?("#{file_path}/source/css")
    assert Dir.exist?("#{file_path}/source/pages")
    assert Dir.exist?("#{file_path}/source/posts")
    assert Dir.exist?("#{file_path}/source/media")
    assert Dir.exist?("#{file_path}/source/layouts")
  end

  def test_when_create_tree_is_called_the_files_are_created

    if Dir.exist?(file_path)
      FileUtils.remove_dir(file_path)
    end

    structure.create_tree(file_path)
    assert File.exist?("#{file_path}/source/css/main.css")
    assert File.exist?("#{file_path}/source/index.md")
    assert File.exist?("#{file_path}/source/pages/about.md")
    assert File.exist?("#{file_path}/source/posts/welcome_to_hyde.md")
    assert File.exist?("#{file_path}/source/layouts/default.html.erb")
  end

  def test_argument_error_activates_when_directories_previously_exist
    assert_raises(ArgumentError) { structure.create_tree("#{file_path}") }
  end

  def test_new_post_creates_correctly_formatted_md_file
   if Dir.exist?(file_path)
     FileUtils.remove_dir(file_path)
   end
   structure.create_tree(file_path)
   structure.create_post(file_path, ["Juicy", "Post"])
   start_text =  "# *Juicy Post*\n\nYour content here"
   assert_equal start_text, File.read("#{file_path}/source/posts/juicy_post.md")
  end


end
