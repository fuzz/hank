# Hank

[![Gem Version](https://badge.fury.io/rb/hank.svg)](https://badge.fury.io/rb/hank)

Hank manages symlinks between source paths and flattened pathnames within a git repository, making it easier to manage configuration files and collaborate with AI tools.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
$ gem install hank
```

## Usage

Run the `hank` command in the directory where you want to manage your files:

```bash
$ hank
```

If no Hankfile exists, Hank will offer to create one and guide you through selecting files to manage.

To edit an existing Hankfile:

```bash
$ hank edit
```

Check the version:

```bash
$ hank --version
```

## How It Works

Hank maintains a Hankfile (in TOML format) that maps source paths to flattened pathnames within your repository. When you run `hank`, it ensures all source paths are symlinks pointing to their corresponding targets in your repository.

For example, if you want to manage your `.bashrc` file, Hank will:

1. Create a file named `dot--bashrc` in your repository
2. Create a symlink from `~/.bashrc` to this file

This allows you to version control your configuration files while keeping them in their original locations.

## Features

- Manages symlinks between source paths and repository files
- Converts dotfiles to visible files with "dot--" prefix
- Flattens pathnames for better organization
- Detects text files using libmagic
- Provides a simple GUI for file selection
- Integrates with git for version control
- Includes comprehensive test coverage

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fuzz/hank.

## License

The gem is available as open source under the terms of the MIT License.
