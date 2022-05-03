# frozen_string_literal: true

module Views
  class ShortFormat
    COLUMN_COUNT = 3

    def initialize(ls_files)
      @ls_files = ls_files
    end

    def format
      column_width = @ls_files.map { |ls_file| ls_file.name.size }.max
      ls_file_table = generate_ls_file_table
      ls_file_table.map do |row|
        row.map do |ls_file|
          ls_file.name.ljust(column_width)
        end.join(' ').strip
      end.join("\n")
    end

    private

    def generate_ls_file_table
      row_count = (@ls_files.size.to_f / COLUMN_COUNT).ceil
      ls_file_table = @ls_files.each_slice(row_count).to_a
      blank_count = row_count - ls_file_table[-1].size
      blank_ls_files = Array.new(blank_count, LsFile.new(''))
      ls_file_table[-1].push(*blank_ls_files)
      ls_file_table.transpose
    end
  end
end
