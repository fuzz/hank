# frozen_string_literal: true
# typed: false

require "test_helper"

class ValidatorTest < Minitest::Test
  def setup
    @hankfile = Hank::Hankfile.new
    @base_dir = Dir.mktmpdir("hank_test")
    @validator = Hank::Validator.new(@hankfile)
    
    # Override base_dir in validator for testing
    @validator.instance_variable_set(:@base_dir, Pathname.new(@base_dir))
  end

  def teardown
    FileUtils.remove_entry @base_dir
  end

  def test_validate_missing_symlink
    @hankfile.add_mapping("/nonexistent/file", "nonexistent-file")
    
    issues = @validator.validate
    assert_equal 1, issues.size
    assert_equal :missing, issues.first.type
    assert_equal "/nonexistent/file", issues.first.source_path
    assert_equal "nonexistent-file", issues.first.target_path
  end

  def test_validate_not_symlink
    # Create a regular file instead of a symlink
    source_path = File.join(@base_dir, "regular_file")
    FileUtils.touch(source_path)
    
    @hankfile.add_mapping(source_path, "regular_file")
    
    issues = @validator.validate
    assert_equal 1, issues.size
    assert_equal :not_symlink, issues.first.type
    assert_equal source_path, issues.first.source_path
  end

  def test_validate_wrong_target
    # Create a target file
    target_path = File.join(@base_dir, "correct_target")
    FileUtils.touch(target_path)
    
    # Create a wrong target file
    wrong_target = File.join(@base_dir, "wrong_target")
    FileUtils.touch(wrong_target)
    
    # Create a symlink pointing to the wrong target
    source_path = File.join(@base_dir, "symlink")
    FileUtils.ln_s(wrong_target, source_path)
    
    @hankfile.add_mapping(source_path, "correct_target")
    
    issues = @validator.validate
    assert_equal 1, issues.size
    assert_equal :wrong_target, issues.first.type
    assert_equal source_path, issues.first.source_path
    assert_equal wrong_target, issues.first.current_target
  end

  def test_validate_correct_symlink
    # Create a target file
    target_path = File.join(@base_dir, "target")
    FileUtils.touch(target_path)
    
    # Create a symlink pointing to the correct target
    source_path = File.join(@base_dir, "symlink")
    FileUtils.ln_s(target_path, source_path)
    
    @hankfile.add_mapping(source_path, "target")
    
    issues = @validator.validate
    assert_empty issues
  end
end
