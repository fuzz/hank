# frozen_string_literal: true
# typed: strict

module Hank
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

    sig do
      params(
        source_path: String,
        target_path: String,
        force: T::Boolean
      ).returns(T::Boolean)
    end
    def create_symlink(source_path, target_path, force: false)
      source = Pathname.new(source_path)
      target = @base_dir.join(target_path)

      # Ensure the source path directory exists
      FileUtils.mkdir_p(source.dirname) unless source.dirname.directory?

      # Ensure the target exists
      unless target.exist?
        if source.exist?
          if source.directory?
            # If source is a directory, move the entire directory
            FileUtils.mv(source, target)
          elsif !source.symlink? && source.file?
            # If source is a regular file, move it
            FileUtils.mv(source, target)
          else
            # Create empty file or directory as needed
            source.directory? ? FileUtils.mkdir_p(target) : FileUtils.touch(target)
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
        if source.symlink?
          return false unless force

          # Remove existing symlink if force is specified
          FileUtils.rm_rf(source)

        # Skip if symlink already exists and force is not specified

        else
          FileUtils.rm_rf(source)
        end
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
