# frozen_string_literal: true
# typed: strict

module Hank
  class FileSelector
    extend T::Sig
    include Glimmer::LibUI::Application
    
    sig { params(initial_files: T.nilable(T::Array[String])).void }
    def initialize(initial_files = nil)
      @initial_files = T.let(initial_files || [], T::Array[String])
      @selected_files = T.let([], T::Array[String])
      @current_path = T.let(Pathname.new('/'), Pathname)
      @files = T.let([], T::Array[String])
      @result = T.let(nil, T.nilable(T::Array[String]))
      @file_list = T.let(nil, T.nilable(Glimmer::LibUI::CustomControl))
    end

    sig { returns(T.nilable(T::Array[String])) }
    def run
      setup_and_start_ui
      @result
    end

    private

    sig { void }
    def setup_and_start_ui
      application(title: 'Hank File Selector') {
        on_closing do
          @result = @selected_files.empty? ? nil : @selected_files
          true
        end

        window('Hank File Selector', 800, 600) {
          margined true
          
          vertical_box {
            horizontal_box {
              button('Up') {
                on_clicked do
                  navigate_up
                end
              }
              
              entry {
                text @current_path.to_s
                readonly true
              }
              
              button('Refresh') {
                on_clicked do
                  refresh_files
                end
              }
            }
            
            @file_list = table {
              text_column('Name')
              text_column('Type')
              
              cell_rows Array.new
              
              on_selection_changed do |table, selection_data|
                if selection_data
                  row = selection_data.row_at_index
                  if row < @files.size
                    path = File.join(@current_path, @files[row])
                    if File.directory?(path)
                      navigate_to(path)
                    end
                  end
                end
              end
            }
            
            horizontal_box {
              checkbox('Show Hidden Files') {
                checked true
                on_toggled do
                  refresh_files
                end
              }
            }
            
            horizontal_box {
              button('Select') {
                on_clicked do
                  select_current_file
                end
              }
              
              button('Done') {
                on_clicked do
                  @result = @selected_files.empty? ? nil : @selected_files
                  stop
                end
              }
              
              button('Cancel') {
                on_clicked do
                  @result = nil
                  stop
                end
              }
            }
            
            horizontal_box {
              label('Selected Files:')
            }
            
            area {
              stretchy true
              
              vertical_box {
                @selected_files.each do |file|
                  horizontal_box {
                    label(file)
                    button('X') {
                      on_clicked do
                        @selected_files.delete(file)
                        refresh_selection_display
                      end
                    }
                  }
                end
              }
            }
          }
        }
        
        # Initialize file list
        refresh_files
        
        # Pre-select initial files
        @selected_files = @initial_files.dup
        refresh_selection_display
      }.launch
    end

    sig { void }
    def refresh_files
      @files = []
      
      # Add directories first
      Dir.entries(@current_path.to_s).sort.each do |entry|
        next if entry == '.' || entry == '..'
        
        path = File.join(@current_path, entry)
        
        # Skip if not a directory
        next unless File.directory?(path)
        
        @files << entry
      end
      
      # Then add text files
      Dir.entries(@current_path.to_s).sort.each do |entry|
        next if entry == '.' || entry == '..'
        
        path = File.join(@current_path, entry)
        
        # Skip if not a file or is a symlink
        next if File.directory?(path) || File.symlink?(path)
        
        # Skip if not a text file
        next unless PathUtils.is_text_file?(path)
        
        @files << entry
      end
      
      # Update table
      update_file_list
    end

    sig { void }
    def update_file_list
      rows = []
      
      @files.each do |file|
        path = File.join(@current_path, file)
        if File.directory?(path)
          rows << [file, 'Directory']
        else
          rows << [file, 'File']
        end
      end
      
      @file_list.cell_rows = rows
    end

    sig { void }
    def navigate_up
      @current_path = @current_path.parent
      refresh_files
    end

    sig { params(path: String).void }
    def navigate_to(path)
      @current_path = Pathname.new(path)
      refresh_files
    end

    sig { void }
    def select_current_file
      selection = @file_list.selection_for_click_index
      return if selection.nil?
      
      row = selection.row_at_index
      if row < @files.size
        file = @files[row]
        path = File.join(@current_path, file)
        
        # Only select files, not directories
        if File.file?(path) && !File.symlink?(path)
          full_path = path.to_s
          if @selected_files.include?(full_path)
            @selected_files.delete(full_path)
          else
            @selected_files << full_path
          end
          refresh_selection_display
        end
      end
    end

    sig { void }
    def refresh_selection_display
      # This would need to be implemented differently in a real UI
      # For now, we'll just print to console
      puts "Selected files: #{@selected_files.join(', ')}"
    end
  end
end
