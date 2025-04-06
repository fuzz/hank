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
        force: T::Boolean,
        backup: T::Boolean
      ).void
    end
    def create_symlink(source_path, target_path, force: false, backup: false)
      source = Pathname.new(source_path)
      target = @base_dir.join(target_path)
      
      # Ensure the source path directory exists
      FileUtils.mkdir_p(source.dirname) unless source.dirname.directory?
      
      # Ensure the target file exists
      unless target.exist?
        # If source exists and is a regular file, copy it to target
        if source.exist? && !source.symlink? && source.file?
          FileUtils.cp(source, target)
        else
          # Otherwise create an empty file as the target
          FileUtils.touch(target)
        end
      end
      
      # Handle existing destination
      if source.exist?
        if source.symlink?
          if force
            # Remove existing symlink if force is specified
            FileUtils.rm(source)
          else
            return # Skip if symlink already exists and force is not specified
          end
        elsif backup
          # Backup existing file
          backup_path = "#{source_path}.bak.#{Time.now.to_i}"
          FileUtils.cp(source, backup_path)
          FileUtils.rm(source)
          puts "Created backup of #{source_path} at #{backup_path}".green
        else
          return # Skip if file exists and backup is not specified
        end
      end
      
      # Create the symlink
      FileUtils.ln_s(target.to_s, source.to_s)
      puts "Created symlink: #{source} -> #{target}".green
    end

    sig { params(source_path: String).void }
    def remove_mapping(source_path)
      @hankfile.remove_mapping(source_path)
      @hankfile.save
      puts "Removed #{source_path} from Hankfile".green
    end
  end
end
