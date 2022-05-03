# frozen_string_literal: true

module Views
  class LongFormat
    FILE_TYPE_TABLE = {
      'file' => '-',
      'directory' => 'd'
    }.freeze

    PERMISSION_TABLE = {
      '1' => '--x',
      '2' => '-w-',
      '3' => '-wx',
      '4' => 'r--',
      '5' => 'r-x',
      '6' => 'rw-',
      '7' => 'rwx'
    }.freeze

    def initialize(ls_files)
      @ls_files = ls_files
    end

    def format
      total = @ls_files.sum(&:block_size)
      header = "total #{total}"
      max_size_table = generate_max_size_table
      body = @ls_files.map do |ls_file|
        column = []
        column << "#{format_mode(ls_file)} "
        column << ls_file.link_count.to_s.rjust(max_size_table[:link_count])
        column << "#{ls_file.owner_name.ljust(max_size_table[:owner_name])} "
        column << "#{ls_file.group_name.ljust(max_size_table[:group_name])} "
        column << ls_file.bytesize.to_s.rjust(max_size_table[:bytesize])
        column << ls_file.mtime.strftime('%b %d %H:%M')
        column << ls_file.name
        column.join(' ')
      end
      [header, *body].join("\n")
    end

    private

    def format_mode(ls_file)
      file_type = FILE_TYPE_TABLE[ls_file.file_type]
      permission = ls_file.permission.each_char.map { |c| PERMISSION_TABLE[c] }.join

      file_type + permission
    end

    def generate_max_size_table
      ret = {
        link_count: 0,
        owner_name: 0,
        group_name: 0,
        bytesize: 0
      }

      @ls_files.each do |ls_file|
        ret[:link_count] = [ret[:link_count], ls_file.link_count.to_s.size].max
        ret[:owner_name] = [ret[:owner_name], ls_file.owner_name.size].max
        ret[:group_name] = [ret[:group_name], ls_file.group_name.size].max
        ret[:bytesize] = [ret[:bytesize], ls_file.bytesize.to_s.size].max
      end

      ret
    end
  end
end
