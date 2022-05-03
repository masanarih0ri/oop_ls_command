# frozen_string_literal: true

require 'optparse'

class Params
  def initialize(argv)
    opt = OptionParser.new
    @params = {}
    # ここでparamsのhashの値を作る
    # { a: true, l: false, r: true } みたいなイメージ
    opt.on('-a') { @params[:a] = true }
    opt.on('-l') { @params[:l] = true }
    opt.on('-r') { @params[:r] = true }

    # opt.parse!でオプションではない引数（今回はファイルディレクトリなど）を扱えるようにする
    @target_directory = opt.parse!(argv)[0]
  end

  def dot_match?
    !!@params[:a]
  end

  def reverse?
    !!@params[:r]
  end

  def long_format?
    !!@params[:l]
  end

  def target_directory
    # 引数にディレクトリが渡されないケースも考慮する
    @target_directory || Dir.getwd
  end
end
