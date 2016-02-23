require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/hyde'
require 'fileutils'

class StructureTest < Minitest::Test
  def test_when_new_is_argv0_it_creates_new_file_structure
    structure = Structure.new
    file_path = "/Users/Gurusundesh/turing/1module/hyde/test_files"

    if Dir.exist?("#{file_path}")
      FileUtils.remove_dir("#{file_path}")
    end

    structure.create_tree("#{file_path}")
    assert Dir.exist?("#{file_path}/source")
    assert Dir.exist?("#{file_path}/source/css")
    assert Dir.exist?("#{file_path}/source/pages")
    assert Dir.exist?("#{file_path}/source/posts")
  end

  def test_when_create_tree_is_called_the_files_are_created
    structure = Structure.new
    file_path = "/Users/Gurusundesh/turing/1module/structure/test_files"

    if Dir.exist?("#{file_path}")
      FileUtils.remove_dir("#{file_path}")
    end

    structure.create_tree("#{file_path}")
    assert File.exist?("#{file_path}/source/css/main.css")
    assert File.exist?("#{file_path}/source/index.md")
    assert File.exist?("#{file_path}/source/about.md")
    assert File.exist?("#{file_path}/source/posts/welcome_to_structure.md")
  end

  def test_argument_error_activates_when_directories_previously_exist
    structure = Structure.new
    file_path = "/Users/Gurusundesh/turing/1module/hyde/test_files"

    assert_raises(ArgumentError) { structure.create_tree("#{file_path}") }
  end
end
