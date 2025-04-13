# frozen_string_literal: true
# typed: strict

module Hank
  # Validates the integrity of symlinks
  class Validator
    extend T::Sig

    # Represents a validation issue with a symlink
    class Issue < T::Struct
      const :type, Symbol # :missing, :wrong_target, :not_symlink
      const :source_path, String
      const :target_path, String
      const :current_target, T.nilable(String)
    end

    sig { params(hankfile: Hankfile).void }
    def initialize(hankfile)
      @hankfile = T.let(hankfile, Hankfile)
      @base_dir = T.let(Pathname.new(Dir.pwd), Pathname)
    end

    sig { returns(T::Array[Issue]) }
    def validate
      issues = []

      @hankfile.mappings.each do |source_path, target_path|
        source = Pathname.new(source_path)
        target = @base_dir.join(target_path)

        if !source.exist?
          # Source path doesn't exist
          issues << Issue.new(
            type: :missing,
            source_path: source_path,
            target_path: target_path,
            current_target: nil
          )
        elsif !source.symlink?
          # Source path exists but is not a symlink
          issues << Issue.new(
            type: :not_symlink,
            source_path: source_path,
            target_path: target_path,
            current_target: nil
          )
        else
          # Source path is a symlink, check if it points to the correct target
          actual_target = Pathname.new(File.readlink(source.to_s))

          if actual_target != target && actual_target.expand_path != target.expand_path
            issues << Issue.new(
              type: :wrong_target,
              source_path: source_path,
              target_path: target_path,
              current_target: actual_target.to_s
            )
          end
        end
      end

      issues
    end
  end
end
