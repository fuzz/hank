# frozen_string_literal: true

require_relative "lib/hank/version"

Gem::Specification.new do |spec|
  spec.name = "hank"
  spec.version = Hank::VERSION
  spec.authors = ["Fuzz Leonard"]
  spec.email = ["ink@fuzz.ink"]

  spec.summary = "Symlink manager for easier file management and AI collaboration"
  spec.description = "Hank manages symlinks between source paths and flattened pathnames within a git repository, making it easier to manage configuration files and collaborate with AI tools."
  spec.homepage = "https://github.com/fuzz/hank"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/fuzz/hank"
  spec.metadata["changelog_uri"] = "https://github.com/fuzz/hank/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "bin"
  spec.executables = ["hank"]
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "thor", "~> 1.2"
  spec.add_dependency "toml-rb", "~> 2.2"
  spec.add_dependency "sorbet-runtime", "~> 0.5"
  spec.add_dependency "glimmer-dsl-libui", "~> 0.7"
  spec.add_dependency "ruby-filemagic", "~> 0.7"
  spec.add_dependency "colorize", "~> 0.8"
  spec.add_dependency "diffy", "~> 3.4"

  # Development dependencies
  spec.add_development_dependency "minitest", "~> 5.16"
  spec.add_development_dependency "minitest-reporters", "~> 1.5"
  spec.add_development_dependency "sorbet", "~> 0.5"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop", "~> 1.36"
  spec.add_development_dependency "simplecov", "~> 0.21"
end
