# frozen_string_literal: true
# typed: false

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'hank'
require 'tmpdir'

require 'minitest/autorun'
require 'minitest/reporters'
require 'simplecov'

# Configure SimpleCov
SimpleCov.start do
  add_filter '/test/'
end

# Configure Minitest reporters
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]

# Create test helper module
module HankTestHelpers
  def setup_hankfile_test
    # Set environment variable to use temp file
    @temp_dir = Dir.mktmpdir('hank_test')
    @temp_hankfile_path = File.join(@temp_dir, 'Hankfile')
    @original_hankfile_env = ENV['HANKFILE']
    ENV['HANKFILE'] = @temp_hankfile_path
  end
  
  def teardown_hankfile_test
    # Restore original environment variable
    if @original_hankfile_env
      ENV['HANKFILE'] = @original_hankfile_env
    else
      ENV.delete('HANKFILE')
    end
    
    # Clean up temp directory
    FileUtils.remove_entry @temp_dir if @temp_dir && Dir.exist?(@temp_dir)
  end

  def temp_hankfile_path
    @temp_hankfile_path
  end
end
