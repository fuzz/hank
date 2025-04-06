# frozen_string_literal: true
# typed: false

require "test_helper"

class HankfileTest < Minitest::Test
  def setup
    @hankfile = Hank::Hankfile.new
    @temp_file = Tempfile.new(["Hankfile", ""])
    @temp_file.close
  end

  def teardown
    @temp_file.unlink
  end

  def test_add_mapping
    @hankfile.add_mapping("/etc/hosts", "etc-hosts")
    assert_equal({"/etc/hosts" => "etc-hosts"}, @hankfile.mappings)
  end

  def test_remove_mapping
    @hankfile.add_mapping("/etc/hosts", "etc-hosts")
    @hankfile.remove_mapping("/etc/hosts")
    assert_empty @hankfile.mappings
  end

  def test_to_s
    @hankfile.add_mapping("/etc/hosts", "etc-hosts")
    assert_match(/\[mappings\]/, @hankfile.to_s)
    assert_match(/\/etc\/hosts/, @hankfile.to_s)
    assert_match(/etc-hosts/, @hankfile.to_s)
  end

  def test_from_file
    File.write(@temp_file.path, <<~TOML)
      [mappings]
      "/etc/hosts" = "etc-hosts"
      "/home/user/.bashrc" = "dot--bashrc"
    TOML

    hankfile = Hank::Hankfile.from_file(Pathname.new(@temp_file.path))
    assert_equal 2, hankfile.mappings.size
    assert_equal "etc-hosts", hankfile.mappings["/etc/hosts"]
    assert_equal "dot--bashrc", hankfile.mappings["/home/user/.bashrc"]
  end

  def test_update_mappings
    @hankfile.add_mapping("/etc/hosts", "etc-hosts")
    @hankfile.add_mapping("/etc/resolv.conf", "etc-resolv.conf")
    
    # Update with one existing and one new file
    @hankfile.update_mappings(["/etc/hosts", "/etc/passwd"])
    
    assert_equal 2, @hankfile.mappings.size
    assert_equal "etc-hosts", @hankfile.mappings["/etc/hosts"]
    assert_equal "etc-passwd", @hankfile.mappings["/etc/passwd"]
    refute @hankfile.mappings.key?("/etc/resolv.conf")
  end
end
