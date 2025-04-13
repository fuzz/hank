# frozen_string_literal: true
# typed: false

require 'test_helper'

class PathUtilsTest < Minitest::Test
  def test_flatten_path_with_dotfile
    assert_equal 'dot--bashrc', Hank::PathUtils.flatten_path('.bashrc')
  end

  def test_flatten_path_with_directory
    assert_equal 'etc-hosts', Hank::PathUtils.flatten_path('/etc/hosts')
  end

  def test_flatten_path_with_nested_directory
    assert_equal 'etc-nginx-conf.d-default.conf', Hank::PathUtils.flatten_path('/etc/nginx/conf.d/default.conf')
  end

  def test_text_file
    # Create a temporary text file
    text_file = Tempfile.new(['test', '.txt'])
    text_file.write('This is a test')
    text_file.close

    # Create a temporary binary file
    binary_file = Tempfile.new(['test', '.bin'])
    binary_file.binmode
    binary_file.write("\x00\x01\x02\x03")
    binary_file.close

    assert Hank::PathUtils.text_file?(text_file.path)
    refute Hank::PathUtils.text_file?(binary_file.path)

    text_file.unlink
    binary_file.unlink
  end
end
