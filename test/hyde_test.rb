require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/hyde'
require 'fileutils'

class HydeTest < Minitest::Test
  def test_when_new_is_argv0_it_creates_new_file_structure
    hyde = Hyde.new
    file_path = "/Users/Gurusundesh/turing/1module/hyde/test_files"
    if Dir.exist?("#{file_path}")
      FileUtils.remove_dir("#{file_path}")
    end
    hyde.create_tree("#{file_path}")
    assert Dir.exist?("#{file_path}/source")
    assert Dir.exist?("#{file_path}/source/css")
    assert Dir.exist?("#{file_path}/source/pages")
    assert Dir.exist?("#{file_path}/source/posts")
  end
end
