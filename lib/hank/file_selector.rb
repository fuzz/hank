# frozen_string_literal: true
# typed: strict

require 'curses'

module Hank
  class FileSelector
    extend T::Sig

    sig { params(initial_files: T.nilable(T::Array[String])).void }
    def initialize(initial_files = nil)
      @initial_files = T.let(initial_files || [], T::Array[String])
      @selected_files = T.let(@initial_files.dup, T::Array[String])
      @current_path = T.let(Pathname.new('/'), Pathname)
      @file_list = T.let([], T::Array[String])
      @current_index = T.let(0, Integer)
      @offset = T.let(0, Integer)
    end

    sig { returns(T.nilable(T::Array[String])) }
    def run
      init_curses
      begin
        load_files
        draw_screen
        handle_input
      ensure
        close_curses
      end

      @selected_files.empty? ? nil : @selected_files
    end

    private

    sig { void }
    def init_curses
      Curses.init_screen
      Curses.start_color
      Curses.curs_set(0)  # Hide cursor
      Curses.noecho       # Don't echo input
      Curses.cbreak       # Immediate key input
      Curses.stdscr.keypad(true) # Enable arrow keys

      # Define color pairs
      Curses.init_pair(1, Curses::COLOR_WHITE, Curses::COLOR_BLUE)    # Header/footer
      Curses.init_pair(2, Curses::COLOR_BLACK, Curses::COLOR_WHITE)   # Selected item
      Curses.init_pair(3, Curses::COLOR_GREEN, Curses::COLOR_BLACK)   # Directory
      Curses.init_pair(4, Curses::COLOR_WHITE, Curses::COLOR_BLACK)   # File
      Curses.init_pair(5, Curses::COLOR_YELLOW, Curses::COLOR_BLACK)  # Selected file
    end

    sig { void }
    def close_curses
      Curses.close_screen
    end

    sig { void }
    def load_files
      @file_list = []

      # Add parent directory option
      @file_list << '..'

      # Add directories
      dirs = Dir.entries(@current_path.to_s)
                .select { |entry| File.directory?(File.join(@current_path, entry)) && entry != '.' && entry != '..' }
                .sort
                .map { |entry| "#{entry}/" }

      @file_list.concat(dirs)

      # Add text files
      files = Dir.entries(@current_path.to_s)
                 .select do |entry|
        path = File.join(@current_path, entry)
        File.file?(path) && !File.symlink?(path) && PathUtils.is_text_file?(path)
      end
               .sort

      @file_list.concat(files)

      # Reset current index if needed
      @current_index = 0 if @current_index >= @file_list.length
      @offset = 0 if @offset >= @file_list.length
    end

    sig { void }
    def draw_screen
      Curses.clear
      height = Curses.lines
      width = Curses.cols

      # Draw header
      Curses.attron(Curses.color_pair(1))
      Curses.setpos(0, 0)
      Curses.addstr(' ' * width)
      Curses.setpos(0, 0)
      Curses.addstr(" Hank File Selector - #{@current_path}")
      Curses.attroff(Curses.color_pair(1))

      # Draw file list
      visible_items = height - 4 # Header, footer, and help line
      @offset = @current_index - visible_items + 1 if @current_index >= @offset + visible_items
      @offset = @current_index if @current_index < @offset

      visible_files = @file_list[@offset, visible_items]
      visible_files&.each_with_index do |file, idx|
        row = idx + 1
        real_idx = idx + @offset
        is_selected = @current_index == real_idx
        is_dir = file.end_with?('/')
        is_chosen = @selected_files.include?(File.join(@current_path, file.chomp('/')).to_s)

        # Select color based on file type and selection status
        if is_selected
          Curses.attron(Curses.color_pair(2))
        elsif is_dir
          Curses.attron(Curses.color_pair(3))
        elsif is_chosen
          Curses.attron(Curses.color_pair(5))
        else
          Curses.attron(Curses.color_pair(4))
        end

        Curses.setpos(row, 0)
        Curses.addstr(' ' * width)
        Curses.setpos(row, 0)
        prefix = is_chosen ? '[*] ' : '[ ] '
        Curses.addstr("#{prefix}#{file}")

        # Reset attributes
        if is_selected
          Curses.attroff(Curses.color_pair(2))
        elsif is_dir
          Curses.attroff(Curses.color_pair(3))
        elsif is_chosen
          Curses.attroff(Curses.color_pair(5))
        else
          Curses.attroff(Curses.color_pair(4))
        end
      end

      # Draw help line
      Curses.setpos(height - 2, 0)
      Curses.addstr(' ' * width)
      Curses.setpos(height - 2, 0)
      Curses.addstr(' ↑/↓: Navigate | Space: Select | Enter: Open | q: Quit | d: Done')

      # Draw footer with stats
      Curses.attron(Curses.color_pair(1))
      Curses.setpos(height - 1, 0)
      Curses.addstr(' ' * width)
      Curses.setpos(height - 1, 0)
      Curses.addstr(" Selected: #{@selected_files.size} files")
      Curses.attroff(Curses.color_pair(1))

      Curses.refresh
    end

    sig { returns(T.nilable(T::Array[String])) }
    def handle_input
      loop do
        draw_screen
        key = Curses.getch

        case key
        when Curses::KEY_UP
          @current_index -= 1 if @current_index.positive?
        when Curses::KEY_DOWN
          @current_index += 1 if @current_index < @file_list.length - 1
        when Curses::KEY_ENTER, 10, 13 # Enter key
          file = @file_list[@current_index]
          if file == '..'
            @current_path = @current_path.parent
            load_files
          elsif T.must(file).end_with?('/')
            @current_path = @current_path.join(T.must(file).chomp('/'))
            load_files
          end
        when ' ' # Space key for selection
          file = @file_list[@current_index]
          next if file == '..' # Skip parent directory

          path = if T.must(file).end_with?('/') # Directory
                   File.join(@current_path, T.must(file).chomp('/')).to_s
                 else # File
                   File.join(@current_path, file).to_s
                 end
          if @selected_files.include?(path)
            @selected_files.delete(path)
          else
            @selected_files << path
          end
        when 'q', 'Q'
          return nil # Cancel
        when 'd', 'D'
          return @selected_files
        end
      end
    end
  end
end
