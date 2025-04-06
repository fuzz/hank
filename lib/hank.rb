# frozen_string_literal: true
# typed: strict

require "sorbet-runtime"
require "thor"
require "toml-rb"
require "filemagic"
require "diffy"
require "colorize"
require "pathname"
require "fileutils"
require "glimmer-dsl-libui"

require_relative "hank/version"
require_relative "hank/hankfile"
require_relative "hank/path_utils"
require_relative "hank/symlink_manager"
require_relative "hank/file_selector"
require_relative "hank/validator"
require_relative "hank/cli"

module Hank
  class Error < StandardError; end
  # Your code goes here...
end
