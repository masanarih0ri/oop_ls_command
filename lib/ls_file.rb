require 'etc'
require 'pathname'

class LsFile
  def self.all(params)
    pattern = File.join(params.target_directory, '*')
    # patternという名前は思いつかないというか、ここにpatternが渡るというのがイメージできなかった
    flags = params.dot_match? ? [File::FNM_DOTMATCH] : []
    paths = Dir.glob(pattern, *flags)
    if params.dot_match?
      paths << File.join(params.target_directory, '..')
    end
    sorted_paths = params.reverse? ? paths.sort.reverse : paths.sort
    sorted_paths.map { |path| LsFile.new(path)}
  end

  def initialize(path)
    @pathname = Pathname.new(path)
  end

  def name
    @pathname.basename.to_s
  end

  def block_size
    file_stat.blocks
  end

  def file_type
    file_stat.ftype
  end

  def permission
    file_stat.mode.to_s(8)[-3..-1]
  end

  def link_count
    @pathname.directory? ? @pathname.entries.size : 1
  end

  def owner_name
    Etc.getpwuid(file_stat.uid).name
  end

  def group_name
    Etc.getgrgid(file_stat.gid).name
  end

  def bytesize
    @pathname.size
  end

  def mtime
    file_stat.mtime
  end

  def to_s
    name
  end

  private

  def file_stat
    @pathname.stat
  end
end