# frozen_string_literal: true
# typed: false

require "test_helper"

class SymlinkManagerTest < Minitest::Test
  def setup
    @hankfile = Hank::Hankfile.new
    @base_dir = Dir.mktmpdir("hank_test")
    @manager = Hank::SymlinkManager.new(@hankfile)
    
    # Override base_dir in manager for testing
    @manager.instance_variable_set(:@base_dir, Pathname.new(@base_dir))
  end

  def teardown
    FileUtils.remove_entry @base_dir
  end

  def test_create_symlink
    source_path = File.join(@base_dir, "source")
    target_path = "target"
    target_full_path = File.join(@base_dir, target_path)
    
    @manager.create_symlink(source_path, target_path)
    
    assert File.symlink?(source_path)
    assert_equal target_full_path, File.readlink(source_path)
  end

  def test_create_symlink_with_force
    # Create a symlink pointing to wrong target
    source_path = File.join(@base_dir, "source")
    wrong_target = File.join(@base_dir, "wrong")
    FileUtils.touch(wrong_target)
    FileUtils.ln_s(wrong_target, source_path)
    
    # Correct target
    target_path = "target"
    target_full_path = File.join(@base_dir, target_path)
    
    @manager.create_symlink(source_path, target_path, force: true)
    
    assert File.symlink?(source_path)
    assert_equal target_full_path, File.readlink(source_path)
  end

  def test_create_symlink_with_backup
    # Create a regular file
    source_path = File.join(@base_dir, "source")
    File.write(source_path, "original content")
    
    # Target
    target_path = "target"
    
    @manager.create_symlink(source_path, target_path, backup: true)
    
    # Check symlink was created
    assert File.symlink?(source_path)
    
    # Check backup was created
    backup_file = Dir.glob("#{source_path}.bak.*").first
    assert backup_file
    assert_equal "original content", File.read(backup_file)
  end

  def test_install_all
    # Add some mappings
    @hankfile.add_mapping(File.join(@base_dir, "file1"), "target1")
    @hankfile.add_mapping(File.join(@base_dir, "file2"), "target2")
    
    @manager.install_all
    
    assert File.symlink?(File.join(@base_dir, "file1"))
    assert File.symlink?(File.join(@base_dir, "file2"))
  end

  def test_remove_mapping
    @hankfile.add_mapping(File.join(@base_dir, "file1"), "target1")
    @hankfile.add_mapping(File.join(@base_dir, "file2"), "target2")
    
    @manager.remove_mapping(File.join(@base_dir, "file1"))
    
    assert_equal 1, @hankfile.mappings.size
    refute @hankfile.mappings.key?(File.join(@base_dir, "file1"))
  end
end
