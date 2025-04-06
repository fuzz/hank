# frozen_string_literal: true
# typed: strict

module Hank
  class CLI < Thor
    extend T::Sig

    desc '', 'Verify or create symlinks based on Hankfile'
    def index
      hankfile_path = Pathname.new(Dir.pwd).join('Hankfile')

      if hankfile_path.exist?
        process_existing_hankfile(hankfile_path)
      else
        create_new_hankfile(hankfile_path)
      end
    end
    default_task :index

    desc 'edit', 'Edit Hankfile using GUI file browser'
    def edit
      hankfile_path = Pathname.new(Dir.pwd).join('Hankfile')

      unless hankfile_path.exist?
        puts "No Hankfile found in current directory. Run 'hank' to create one.".red
        exit 1
      end

      hankfile = Hankfile.from_file(hankfile_path)
      file_selector = FileSelector.new(hankfile.mappings.keys)
      selected_files = file_selector.run

      if selected_files
        hankfile.update_mappings(selected_files)
        puts 'Hankfile updated with selected files.'
      else
        puts 'Edit cancelled.'
      end
    end

    map '--version' => :version
    desc '--version', 'Display version information'
    def version
      puts "Hank version #{Hank::VERSION}"
    end

    private

    sig { params(hankfile_path: Pathname).void }
    def process_existing_hankfile(hankfile_path)
      hankfile = Hankfile.from_file(hankfile_path)
      symlink_manager = SymlinkManager.new(hankfile)
      validator = Validator.new(hankfile)

      issues = validator.validate

      if issues.empty?
        puts 'All symlinks are correctly configured.'.green
      else
        puts "Found #{issues.size} issues:".yellow

        issues.each do |issue|
          handle_issue(issue, symlink_manager)
        end
      end
    end

    sig { params(issue: Validator::Issue, symlink_manager: SymlinkManager).void }
    def handle_issue(issue, symlink_manager)
      source_path = issue.source_path
      target_path = issue.target_path

      case issue.type
      when :missing
        puts "Creating symlink for #{source_path} -> #{target_path}".yellow
        symlink_manager.create_symlink(source_path, target_path)
      when :wrong_target
        puts "Symlink #{source_path} points to wrong target:".red
        puts "  Current: #{issue.current_target}"
        puts "  Expected: #{target_path}"
        puts 'Options:'
        puts '  1. Update symlink to point to correct target'
        puts '  2. Remove from Hankfile'
        print 'Choose option (1/2): '
        choice = gets.chomp

        if choice == '1'
          symlink_manager.create_symlink(source_path, target_path, force: true)
        elsif choice == '2'
          symlink_manager.remove_mapping(source_path)
        else
          puts 'Invalid choice. Skipping.'.red
        end
      when :not_symlink
        if File.directory?(source_path)
          puts "#{source_path} is a directory, skipping.".yellow
        else
          puts "#{source_path} is a regular file, not a symlink:".red
          if File.file?(source_path) && File.file?(target_path.expand_path(symlink_manager.base_dir))
            diff = Diffy::Diff.new(source_path, target_path.expand_path(symlink_manager.base_dir),
                                   source: 'files').to_s(:color)
            puts diff
          end
          puts 'Options:'
          puts '  1. Replace with symlink (backup existing file)'
          puts '  2. Remove from Hankfile'
          print 'Choose option (1/2): '
          choice = gets.chomp

          if choice == '1'
            symlink_manager.create_symlink(source_path, target_path, backup: true)
          elsif choice == '2'
            symlink_manager.remove_mapping(source_path)
          else
            puts 'Invalid choice. Skipping.'.red
          end
        end
      end
    end

    sig { params(hankfile_path: Pathname).void }
    def create_new_hankfile(_hankfile_path)
      puts 'No Hankfile found in current directory.'
      print 'Would you like to create one? (y/n): '

      answer = gets.chomp.downcase
      return unless answer == 'y'

      file_selector = FileSelector.new
      selected_files = file_selector.run

      return puts 'No files selected. Exiting.'.yellow if selected_files.nil? || selected_files.empty?

      hankfile = Hankfile.new
      Pathname.new(Dir.pwd)

      selected_files.each do |source_path|
        target_path = PathUtils.flatten_path(source_path)
        hankfile.add_mapping(source_path, target_path)
      end

      puts "\nProposed Hankfile contents:"
      puts hankfile

      print "\nWould you like to proceed to copy source files and create symlinks? (y/n): "
      answer = gets.chomp.downcase

      if answer == 'y'
        symlink_manager = SymlinkManager.new(hankfile)
        symlink_manager.install_all
        puts 'Hankfile created and symlinks installed.'.green
      else
        puts 'Operation cancelled.'.yellow
      end
    end
  end
end
