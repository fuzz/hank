# frozen_string_literal: true
# typed: strict

module Hank
  class PathUtils
    extend T::Sig

    sig { params(path: String).returns(String) }
    def self.flatten_path(path)
      pathname = Pathname.new(path)

      # Handle dotfiles
      basename = pathname.basename.to_s
      basename = "dot--#{basename[1..]}" if basename.start_with?('.')

      # Flatten directory structure
      if pathname.dirname.to_s != '.'
        dirname = pathname.dirname.to_s.gsub(%r{^/}, '').gsub('/', '-')
        "#{dirname}-#{basename}"
      else
        basename
      end
    end

    sig { params(path: String).returns(T::Boolean) }
    def self.is_text_file?(path)
      return false unless File.file?(path)

      # Use libmagic to determine if file is text
      begin
        # Create a new instance for each call to avoid allocator warnings
        magic = FileMagic.open(FileMagic::MAGIC_MIME)
        mime_type = magic.file(path)
        magic.close
        mime_type.start_with?('text/') ||
          mime_type.include?('xml') ||
          mime_type.include?('json') ||
          mime_type.include?('script')
      rescue StandardError => e
        puts "Warning: Error detecting file type: #{e.message}".yellow
        # Fall back to simple text check
        File.open(path) { |f| f.read(1024).valid_encoding? }
      end
    end
  end
end
