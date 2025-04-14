# frozen_string_literal: true
# typed: strict

module Hank
  # Manages creation and removal of symlinks
  class SymlinkManager
    extend T::Sig

    sig { returns(Pathname) }
    attr_reader :base_dir

    sig { params(hankfile: Hankfile).void }
    def initialize(hankfile)
      @hankfile = T.let(hankfile, Hankfile)
      @base_dir = T.let(Pathname.new(Dir.pwd), Pathname)
    end

    sig { void }
    def install_all
      @hankfile.mappings.each do |source_path, target_path|
        create_symlink(source_path, target_path)
      end
      @hankfile.save
    end

    sig { params(source: Pathname, target: Pathname).void }
    def create_empty_target(source, target)
      if source.directory?
        FileUtils.mkdir_p(target)
      else
        FileUtils.touch(target)
      end
    end

    sig { params(source_path: String, target_path: String, force: T::Boolean).returns(T::Boolean) }
    def create_symlink(source_path, target_path, force: false)
      source = Pathname.new(source_path)
      target = @base_dir.join(target_path)

      # Ensure the source path directory exists
      FileUtils.mkdir_p(source.dirname) unless source.dirname.directory?

      # Ensure the target exists
      unless target.exist?
        if source.exist?
          if source.directory? || (!source.symlink? && source.file?)
            # Move the entire directory or file to the target location
            FileUtils.mv(source, target)
          else
            # Create empty file or directory as needed
            create_empty_target(source, target)
          end
        elsif source_path.end_with?('/')
          # Create empty file or directory based on the source path name
          # (If we can infer it's supposed to be a directory)
          FileUtils.mkdir_p(target)
        else
          FileUtils.touch(target)
        end
      end

      # Handle existing destination
      if source.exist?
        if source.symlink? && !force
          return false

          # Remove existing symlink if force is specified

          # Skip if symlink already exists and force is not specified

        end

        FileUtils.rm_rf(source)
      end

      # Create the symlink
      begin
        FileUtils.ln_s(target.to_s, source.to_s)
        puts "Created symlink: #{source} -> #{target}".green
        true
      rescue StandardError => e
        puts "⚠️ Failed to create symlink: #{source} -> #{target}: #{e.message}".red
        false
      end
    end

    sig { params(source_path: String).void }
    def remove_mapping(source_path)
      @hankfile.remove_mapping(source_path)
      @hankfile.save
      puts "Removed #{source_path} from Hankfile".green
    end
  end
end
