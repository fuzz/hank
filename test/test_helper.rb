# frozen_string_literal: true
# typed: false

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "hank"

require "minitest/autorun"
require "minitest/reporters"
require "simplecov"

# Configure SimpleCov
SimpleCov.start do
  add_filter "/test/"
end

# Configure Minitest reporters
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]
