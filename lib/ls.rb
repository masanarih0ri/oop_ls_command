require_relative 'params'
require_relative 'ls_file'
require_relative 'views/short_format'

class Ls
  def main
    # 起動時引数を受け取る
    params = Params.new(ARGV)
    # ファイルの一覧を取得する
    ls_files = LsFile.all(params)
    # ファイルの一覧をviewに表示
    if params.long_format?
      render 'long'
    else
      puts Views::ShortFormat.new(ls_files).format
    end
  end
end

Ls.new.main
