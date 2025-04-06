# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build/Test Commands
- Run all tests: `bundle exec rake test`
- Run single test: `bundle exec ruby -Itest test/hank/specific_test.rb -n test_method_name`
- Run linter: `bundle exec rake rubocop`
- Default task (tests + lint): `bundle exec rake`
- Build gem: `bundle exec rake build`
- Install gem locally: `bundle exec rake install`

## Code Style Guidelines
- **Typing**: Uses Sorbet for static typing with `# typed: strict` at top of files and `extend T::Sig`
- **Type Signatures**: Methods defined with `sig { params(...).returns(...) }` blocks
- **Imports**: Require statements at top with `# frozen_string_literal: true` comment
- **Formatting**: 2-space indentation, RuboCop enforced style
- **Naming**: Snake_case for methods/variables, CamelCase for classes/modules
- **Namespacing**: All classes under `Hank::` module
- **Error Handling**: Custom `Hank::Error` class, specific rescue blocks with colorized warnings
- **Testing**: Minitest framework with `_test.rb` suffix in `test/` directory mirroring lib structure
- **Dependencies**: Managed in gemspec with versioned requirements