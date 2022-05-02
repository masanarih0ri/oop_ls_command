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

  def to_s
    name
  end
end