require_relative 'params'

class Ls
  def main
    # 起動時引数を受け取る
    params = Params.new(ARGV)
    # ファイルの一覧を取得する
    # @ls_files = LsFile.all(parmas)
    # ファイルの一覧をviewに表示
    # if params.long_format?
    #   render 'long'
    # else
    #   render 'short'
    # end
  end
end

Ls.new.main
