# frozen_string_literal: true
# typed: strict

module Hank
  class Hankfile
    extend T::Sig

    sig { returns(T::Hash[String, String]) }
    attr_reader :mappings

    sig { void }
    def initialize
      @mappings = T.let({}, T::Hash[String, String])
    end

    sig { params(source_path: String, target_path: String).void }
    def add_mapping(source_path, target_path)
      @mappings[source_path] = target_path
    end

    sig { params(source_path: String).void }
    def remove_mapping(source_path)
      @mappings.delete(source_path)
    end

    sig { params(selected_files: T::Array[String]).void }
    def update_mappings(selected_files)
      # Keep mappings for selected files, add new ones
      new_mappings = {}
      
      selected_files.each do |source_path|
        if @mappings.key?(source_path)
          new_mappings[source_path] = @mappings[source_path]
        else
          new_mappings[source_path] = PathUtils.flatten_path(source_path)
        end
      end
      
      @mappings = new_mappings
      save
    end

    sig { void }
    def save
      File.write("Hankfile", to_s)
    end

    sig { returns(String) }
    def to_s
      TomlRB.dump({'mappings' => @mappings})
    end

    sig { params(file_path: Pathname).returns(Hankfile) }
    def self.from_file(file_path)
      content = File.read(file_path)
      data = TomlRB.parse(content)
      
      hankfile = Hankfile.new
      if data['mappings'].is_a?(Hash)
        data['mappings'].each do |source_path, target_path|
          hankfile.add_mapping(source_path, target_path.to_s)
        end
      end
      
      hankfile
    end
  end
end
